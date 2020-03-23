/* Specify the provider and access details */
provider "aws" {
  region = "${var.aws_region}"
}

/* Random ID for unique resource name */
 resource "random_id" "unique-id" {
   byte_length = 4
}


/* ELB for Web/Application Servers */
 resource "aw_elb" "web-elb" {
   name = "elb-web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   security_groups = ["${aws_security_group.elb-sg.id}"]

   subnets = ["${aws_subnet.subnet.*.id}"]
   listener {
     instance_port = 80
     instance_protocol = "http"
     lb_port = 80
     lb_protocol = "http"
   }

   health_check {
     healthy_threshold = 2
     unhealthy_threshold = 2
     timeout = 3
     target = "TCP:80"
     interval = 30
   }

   cross_zone_load_balancing = true
   idle_timeout = 400
   connection_draining = true
   connection_draining_timeout = 400

   tags {
     Name = "elb-web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   }
 }

 /* Launch Configuration for Autoscalling Group */
 resource "aws_launch_configuration" "web-lc" {
   name_prefix = "lc-web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}-"
   image_id = "${var.aws_ami["${var.aws_region}"]}"
   instance_type = "${var.app_instance_type}"
   security_groups = ["${aws_security_group.default.id}"]
   user_data = "${data.template_file.bootstrap.rendered}"
   key_name = "ExamKey"

   lifecycle {
     create_before_destroy = true
   }
 }

# /* Template for bootstrap */
 data "template_file" "bootstrap" {
     template = "${file("files/bootstrap.sh")}"
     vars {
         cluster_name = "web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
         roles = "web"
         environment = "${var.environment}"
     }

 }

 /* Autoscalling Group */
 resource "aws_autoscaling_group" "web-asg" {
   availability_zones = ["${var.availability_zones}"]
   name = "asg-web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   max_size = "${var.asg_max}"
   min_size = "${var.asg_min}"
   desired_capacity = "${var.asg_desired}"
   force_delete = true
   launch_configuration = "${aws_launch_configuration.web-lc.name}"
   load_balancers = ["${aws_elb.web-elb.name}"]
   vpc_zone_identifier = ["${aws_subnet.subnet.*.id}"]
   tag {
     key = "Name"
     value = "web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
     propagate_at_launch = "true"
   }
   tag {
     key = "Environment"
     value = "${var.environment}"
     propagate_at_launch = "true"
   }
 }

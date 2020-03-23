
/* Security Group for Ec2 Instances */
 resource "aws_security_group" "default" {
   name = "sg_web_${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   vpc_id = "${aws_vpc.main.id}"

   # SSH access from anywhere
   ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   # outbound internet access
   egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
     Name = "sg-ec2-web-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   }
 }

 /* Security Group for ELB */
 resource "aws_security_group" "elb-sg" {
   name = "sg_elb_${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   vpc_id = "${aws_vpc.main.id}"

   # HTTP access from anywhere
   ingress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   # outbound internet access
   egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
     Name = "sg-elb-${var.environment}-${var.full_name}-${random_id.unique-id.hex}"
   }
 }

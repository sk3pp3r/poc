environment = "example"
availability_zones = ["eu-west-1a","eu-west-1b"]
app_instance_type = "t2.micro"
asg_min = "1"
asg_max = "2"
asg_desired = "1"
cidr = "10.0.0.0/16"
vpc_name = "WEB-VPC"
aws_ami = {
  us-east-2 = "ami-0ba720156815aa016"
  eu-west-1 = "ami-0decfcfaebf6c20d2"
  us-east-1 = "ami-05b5d7bcc8989ab48"
  us-west-2 = "ami-02ce5c117cf3301ea"
}

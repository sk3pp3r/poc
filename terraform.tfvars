environment = "example"
availability_zones = ["us-east-2a","us-east-2b"]
app_instance_type = "t2.micro"
asg_min = "1"
asg_max = "2"
asg_desired = "1"
cidr = "10.0.0.0/16"
vpc_name = "WEB-VPC"
aws_ami = {
  us-east-2 = "ami-5c153439"
  eu-west-1 = "ami-0decfcfaebf6c20d2"
  us-east-1 = "ami-0eeaef18"
  us-west-2 = "ami-97e7c8f7"
}

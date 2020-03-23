/* Variables */
variable "environment" {
    description = "Name of the environment."
}
variable "vpc_name" {
  description = "name of the VPC"
}
variable "cidr" {
  description = "CIDR for the VPC"
}

variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "aws_ami" {
  type="map"
  description = "The AWS AMI to use."
}

variable "availability_zones" {
  type="list"
  description = "List of availability zones."
}

variable "app_instance_type" {
    description = "Instance type for the Application."
}

variable "asg_min" {
  description = "Minimun number of instancess in autoscalling group."
}

variable "asg_max" {
  description = "Maximun number of instancess in autoscalling group."
}

variable "asg_desired" {
  description = "Desired number of instancess in autoscalling group."
}

variable "full_name" {
  description = "Your full name (without spaces)."
}


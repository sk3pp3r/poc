# /Resources

# VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "${var.vpc_name}-${var.full_name}-${random_id.unique-id.hex}"
    CreatedBy = "Terraform"
  }
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "igw-${var.vpc_name}-${var.full_name}-${random_id.unique-id.hex}"
    CreatedBy = "Terraform"
  }
}

resource "aws_route" "r" {
  route_table_id            = "${aws_vpc.main.default_route_table_id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}


#  Subnet Tier
resource "aws_subnet" "subnet" {
     count = "${length(var.availability_zones)}"
     vpc_id = "${aws_vpc.main.id}"
     cidr_block = "${cidrsubnet(var.cidr, length(var.availability_zones) % 2 == 1 ? length(var.availability_zones) / 2 + 1 : length(var.availability_zones) / 2, count.index)}"
     availability_zone = "${element(var.availability_zones,count.index)}"
     map_public_ip_on_launch = true
     tags {
         Name = "${join("-", list(element(var.availability_zones,count.index)))}-${var.full_name}-${random_id.unique-id.hex}"
     }
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


# vpc 
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}

# subnet
resource "aws_subnet" "demo-subnet" {
  cidr_block = "${cidrsubnet(aws_vpc.demo-vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.demo-vpc.id}"
  
  tags = {
    Name = var.subnet_Name
  }
}


# internet gateway
resource "aws_internet_gateway" "demo-internet-gateway" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
tags = {
    Name = var.ig_Name
  }
}

# route table
resource "aws_route_table" "demo-route-table" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-internet-gateway.id}"
  }
tags = {
    Name = var.route_table_Name
  }
}


# association of route table with the subnet
resource "aws_route_table_association" "demo-subnet-association" {
  subnet_id      = "${aws_subnet.demo-subnet.id}"
  route_table_id = "${aws_route_table.demo-route-table.id}"
}


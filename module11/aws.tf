variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.31.0.0/16"
}
variable "public_subnet_cidr_a" {
  default = "172.31.0.0/20"
}
variable "public_subnet_cidr_b" {
  default = "172.31.16.0/20"
}
variable "public_subnet_cidr_c" {
   default = "172.31.32.0/20"
}
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "us-east-1"
  }
resource "aws_vpc" "task11" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "test-vpc"
  }
}
# Define the public subnet
resource "aws_subnet" "public-subnet_a" {
  vpc_id = "${aws_vpc.task11.id}"
  cidr_block = "${var.public_subnet_cidr_a}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"
}
resource "aws_subnet" "public-subnet_b" {
  vpc_id = "${aws_vpc.task11.id}"
  cidr_block = "${var.public_subnet_cidr_b}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"
}
resource "aws_subnet" "public-subnet_c" {
  vpc_id = "${aws_vpc.task11.id}"
  cidr_block = "${var.public_subnet_cidr_c}"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "false"
}
#Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.task11.id}"
}
# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.task11.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}
# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt_a" {
  subnet_id = "${aws_subnet.public-subnet_a.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
resource "aws_route_table_association" "web-public-rt_b" {
  subnet_id = "${aws_subnet.public-subnet_b.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
resource "aws_route_table_association" "web-public-rt_c" {
  subnet_id = "${aws_subnet.public-subnet_c.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
# Define the security group for public subnet
resource "aws_security_group" "sgweb" {
  name = "sgweb"
  description = "Allow incoming HTTP connections & SSH access"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr_a}","${var.public_subnet_cidr_b}","${var.public_subnet_cidr_c}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id="${aws_vpc.task11.id}"
}
resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "${var.aws_key_name}"
  public_key = "${var.aws_public_key}"
}
resource "aws_launch_configuration" "launch-conf-task11" {
  name_prefix   = "launch-conf-task11"
  image_id      = "${var.aws_image}"
  instance_type = "t2.micro"
  key_name = "terraform_ec2_key"
  security_groups    = ["${aws_security_group.sgweb.id}"]
  lifecycle {
    create_before_destroy = true
  }
}
#auto scaling group
resource "aws_autoscaling_group" "asg-task11" {
  name                 = "asg-task11"
  launch_configuration = "${aws_launch_configuration.launch-conf-task11.name}"
  min_size             = 1
  max_size             = 3
  vpc_zone_identifier  = ["${aws_subnet.public-subnet_a.id}","${aws_subnet.public-subnet_b.id}","${aws_subnet.public-subnet_c.id}"]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true 
  target_group_arns         = ["${aws_lb_target_group.main_target.arn}"]
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "sg_lb" {
  name = "vpc_test_elb"
  description = "Allow incoming HTTP connections to Load Balancer"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  vpc_id="${aws_vpc.task11.id}"
}
resource "aws_lb_target_group" "main_target" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.task11.id}"
  target_type = "instance"
}
#Create application LB
resource "aws_lb" "module11-lb" {
  name               = "module11-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg_lb.id}"]
  subnets            = ["${aws_subnet.public-subnet_a.id}","${aws_subnet.public-subnet_b.id}","${aws_subnet.public-subnet_c.id}"]
}
resource "aws_lb_listener" "module11-lb-Listener" {
  load_balancer_arn = "${aws_lb.module11-lb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_lb_target_group.main_target.arn}"
    type             = "forward"
  }
}
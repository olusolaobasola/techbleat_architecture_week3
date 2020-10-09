provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "week3homework"
    key = "twonodesinstances.tfstate"
    region = "eu-west-2"
  }
}

resource "aws_instance" "node_one_nginix" {
  ami                    = "ami-080b750a46edafc2b"
  instance_type          = "t2.micro"
  key_name               = "DAY 2 HOMEWORK"
  vpc_security_group_ids = [aws_security_group.node_one.id]

  tags = {
    Name        = "node one nginx"
    provisioner = "Terraform"
    test        = "yes_no"
  }
}

resource "aws_instance" "node_two_tomcat" {
  ami                    = "ami-080b750a46edafc2b"
  instance_type          = "t2.micro"
  key_name               = "DAY 2 HOMEWORK"
  vpc_security_group_ids = [aws_security_group.node_two.id]

  tags = {
    Name        = "node two tomcat"
    provisioner = "Terraform"
  }
}

resource "aws_security_group" "node_one" {
  name = "node_one_nginix"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "node_two" {
  name = "node_two_tomcat"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


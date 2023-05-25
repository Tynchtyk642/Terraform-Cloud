locals {
  env  = "dev"
  name = "demo"

  ingresses = [
    {
      port       = 443
      cidr_block = ["0.0.0.0/0"]
    },
    {
      port       = 80
      cidr_block = ["0.0.0.0/0"]
    },
    {
      port       = 3306
      cidr_block = [aws_vpc.vpc.cidr_block]
    },
    {
      port       = 22
      cidr_block = [aws_vpc.vpc.cidr_block]
    }
  ]
}




resource "aws_security_group" "dynamic" {
  name   = "${local.env}-sg-${local.name}-dynamic"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = local.ingresses
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_block
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${local.env}-vpc-${local.name}"
  }
}

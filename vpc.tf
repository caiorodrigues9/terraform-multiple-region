resource "aws_vpc" "regiao1_vpc" {
  cidr_block           = var.range_ip
  
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.projeto} VPC"
  }
}

resource "aws_vpc" "regiao2_vpc" {
  cidr_block           = var.range_ip
  
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  provider = aws.west

  tags = {
    Name = "${var.projeto} VPC"
  }
}
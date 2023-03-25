resource "aws_internet_gateway" "regiao1_main" {
  vpc_id = aws_vpc.regiao1_vpc.id
}

resource "aws_route_table" "regiao1_public" {
  vpc_id = aws_vpc.regiao1_vpc.id
}

resource "aws_subnet" "regiao1_public" {
  
  count                   = var.subnet_quantidade
  cidr_block              = "${cidrsubnet(aws_vpc.regiao1_vpc.cidr_block, local.tamanho_subnets, count.index + 1)}"
  availability_zone       = "${data.aws_availability_zones.regiao1_available.names[count.index]}"

  vpc_id                  = aws_vpc.regiao1_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.projeto} public subnet ${count.index + 1}"
  }
}

resource "aws_route_table_association" "regiao1_public" {
  count                   = var.subnet_quantidade

  subnet_id      = aws_subnet.regiao1_public[count.index].id
  route_table_id = aws_route_table.regiao1_public.id
}

resource "aws_route" "regiao1_public" {
  route_table_id         = aws_route_table.regiao1_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.regiao1_main.id
}


#Regiao 2

resource "aws_internet_gateway" "regiao2_main" {
  vpc_id    = aws_vpc.regiao2_vpc.id
  provider  = aws.west
}

resource "aws_route_table" "regiao2_public" {
  vpc_id    = aws_vpc.regiao2_vpc.id
  provider  = aws.west
}

resource "aws_subnet" "regiao2_public" {
  
  count                   = var.subnet_quantidade
  cidr_block              = "${cidrsubnet(aws_vpc.regiao2_vpc.cidr_block, local.tamanho_subnets, count.index + 1)}"
  availability_zone       = data.aws_availability_zones.regiao2_available.names[count.index]
  
  provider                = aws.west

  vpc_id                  = aws_vpc.regiao2_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.projeto} public subnet ${count.index + 1}"
  }
}

resource "aws_route_table_association" "regiao2_public" {
  count          = var.subnet_quantidade

  provider       = aws.west

  subnet_id      = aws_subnet.regiao2_public[count.index].id
  route_table_id = aws_route_table.regiao2_public.id
}

resource "aws_route" "regiao2_public" {
  route_table_id         = aws_route_table.regiao2_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.regiao2_main.id
  provider               = aws.west
}

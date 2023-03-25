resource "aws_instance" "regiao1_main" {
  count = var.quantidade_instancias

  ami           = data.aws_ami.regiao1_linux2.image_id
  instance_type = "t3.micro"
  key_name      = var.key_instance

  subnet_id              = "${aws_subnet.regiao1_public.0.id}"
  vpc_security_group_ids = [aws_security_group.regiao1_main["instances"].id]

  tags = {
    Name = "${var.projeto} ${count.index}"
  }
}

#Região 2

resource "aws_instance" "regiao2_main" {
  count = var.quantidade_instancias
  provider = aws.west

  ami           = data.aws_ami.regiao2_linux2.image_id
  instance_type = "t3.micro"
  key_name      = var.key_instance

  subnet_id              = "${aws_subnet.regiao2_public.0.id}"
  vpc_security_group_ids = [aws_security_group.regiao2_main["instances"].id]

  tags = {
    Name = "${var.projeto} ${count.index}"
  }
}
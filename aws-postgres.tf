resource "aws_db_subnet_group" "regiao1_main" {
  name       = "mydb"
  subnet_ids = "${aws_subnet.regiao1_public.*.id}"

  tags = {
    Name = "My DB subnet group ${var.projeto}"
  }
}

resource "aws_db_instance" "regiao1_main" {
  allocated_storage        = 20
  backup_retention_period  = 7
  db_subnet_group_name     = aws_db_subnet_group.regiao1_main.name
  engine                   = "postgres"
  engine_version           = "12"
  identifier               = "mydb"
  instance_class           = "db.t3.micro"
  multi_az                 = false
  db_name                  = "mydb"
  password                 = "12345678"
  port                     = 5432
  publicly_accessible      = true
  storage_encrypted        = true
  storage_type             = "gp2"
  username                 = "mydb"
  vpc_security_group_ids   = [aws_security_group.regiao1_main["database"].id]
  skip_final_snapshot      = "true"
}

#Região 2

resource "aws_db_subnet_group" "regiao2_main" {
  name       = "mydb"
  subnet_ids = "${aws_subnet.regiao2_public.*.id}"
  provider = aws.west

  tags = {
    Name = "My DB subnet group ${var.projeto}"
  }
}

resource "aws_db_instance" "regiao2_main" {
  provider = aws.west
  allocated_storage        = 20
  backup_retention_period  = 7
  db_subnet_group_name     = aws_db_subnet_group.regiao2_main.name
  engine                   = "postgres"
  engine_version           = "12"
  identifier               = "mydb"
  instance_class           = "db.t3.micro"
  multi_az                 = false
  db_name                  = "mydb"
  password                 = "12345678"
  port                     = 5432
  publicly_accessible      = true
  storage_encrypted        = true
  storage_type             = "gp2"
  username                 = "mydb"
  vpc_security_group_ids   = [aws_security_group.regiao2_main["database"].id]
  skip_final_snapshot      = "true"
}
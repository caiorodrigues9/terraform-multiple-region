resource "aws_security_group" "regiao1_main" {
  for_each = toset(["instances", "database", "loadbalance"])

  name        = "${var.projeto}-${each.key}-sg"
  description = "${var.projeto} SG ${each.key}"
  vpc_id      = aws_vpc.regiao1_vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.projeto} SG ${each.key}"
  }
}

resource "aws_security_group_rule" "regiao1_instances-ssh-all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.regiao1_main["instances"].id
}

resource "aws_security_group_rule" "regiao1_instances_http_only_by_lb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.regiao1_main["instances"].id

  source_security_group_id = aws_security_group.regiao1_main["loadbalance"].id
}

resource "aws_security_group_rule" "regiao1_database_by_instances" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.regiao1_main["database"].id

  source_security_group_id = aws_security_group.regiao1_main["instances"].id
}

resource "aws_security_group_rule" "regiao1_loadbalance_http_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.regiao1_main["loadbalance"].id
}

#Região 2

resource "aws_security_group" "regiao2_main" {
  for_each = toset(["instances", "database", "loadbalance"])

  name        = "${var.projeto}-${each.key}-sg"
  description = "${var.projeto} SG ${each.key}"
  vpc_id      = aws_vpc.regiao2_vpc.id
  provider    = aws.west

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.projeto} SG ${each.key}"
  }
}

resource "aws_security_group_rule" "regiao2_instances-ssh-all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  provider          = aws.west
  security_group_id = aws_security_group.regiao2_main["instances"].id
}

resource "aws_security_group_rule" "regiao2_instances_http_only_by_lb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  provider          = aws.west
  security_group_id = aws_security_group.regiao2_main["instances"].id

  source_security_group_id = aws_security_group.regiao2_main["loadbalance"].id
}

resource "aws_security_group_rule" "regiao2_database_by_instances" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  provider          = aws.west
  security_group_id = aws_security_group.regiao2_main["database"].id

  source_security_group_id = aws_security_group.regiao2_main["instances"].id
}

resource "aws_security_group_rule" "regiao2_loadbalance_http_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  provider          = aws.west
  security_group_id = aws_security_group.regiao2_main["loadbalance"].id
}

resource "aws_lb" "regiao1_lb_main" {
  name               = replace("${var.projeto} LB", " ", "-")
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.regiao1_main["loadbalance"].id]
  
  subnets            = "${aws_subnet.regiao1_public.*.id}"

  tags = {
    Name = "${var.projeto} LB"
  }
}

resource "aws_lb_listener" "regiao1_http_lb_main_listener" {
  load_balancer_arn = aws_lb.regiao1_lb_main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"status\":\"otherwise not routed\" }"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "regiao1_instances" {
  name     = "${var.projeto}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.regiao1_vpc.id
}

resource "aws_lb_target_group_attachment" "regiao1_instances" {
  count = length(aws_instance.regiao1_main.*.id)

  target_group_arn = aws_lb_target_group.regiao1_instances.arn
  target_id        = aws_instance.regiao1_main[count.index].id
  port             = 80
}


#Região 2

resource "aws_lb" "regiao2_lb_main" {
  provider = aws.west
  name               = replace("${var.projeto} LB", " ", "-")
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.regiao2_main["loadbalance"].id]
  subnets            = "${aws_subnet.regiao2_public.*.id}"

  tags = {
    Name = "${var.projeto} LB"
  }
}

resource "aws_lb_listener" "regiao2_http_lb_main_listener" {
  provider = aws.west
  load_balancer_arn = aws_lb.regiao2_lb_main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"status\":\"otherwise not routed\" }"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "regiao2_instances" {
  provider = aws.west
  name     = "${var.projeto}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.regiao2_vpc.id
}

resource "aws_lb_target_group_attachment" "regiao2_instances" {
  provider = aws.west
  count = length(aws_instance.regiao2_main.*.id)

  target_group_arn = aws_lb_target_group.regiao2_instances.arn
  target_id        = aws_instance.regiao2_main[count.index].id
  port             = 80
}
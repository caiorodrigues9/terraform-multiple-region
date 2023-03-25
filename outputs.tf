output "regiao1_vpc_id" {
  value = aws_vpc.regiao1_vpc.id
}

output "regiao2_vpc_id" {
  value = aws_vpc.regiao2_vpc.id
}

output "regiao1_instance_ips" {
  value = aws_instance.regiao1_main.*.public_ip
}

output "regiao1_database_url" {
  value = aws_db_instance.regiao1_main.address
}

output "regiao1_elb_url" {
  value = aws_lb.regiao1_lb_main.dns_name
}

output "regiao1_vpc" {
  value = aws_vpc.regiao1_vpc.id
}

output "regiao2_instance_ips" {
  value = aws_instance.regiao2_main.*.public_ip
}

output "regiao2_database_url" {
  value = aws_db_instance.regiao2_main.address
}

output "regiao2_elb_url" {
  value = aws_lb.regiao2_lb_main.dns_name
}

output "regiao2_vpc" {
  value = aws_vpc.regiao2_vpc.id
}
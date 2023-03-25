variable "regiao1" {
  description = "Regiao 1"
  default = "us-east-1"
}

variable "regiao2" {
  description = "Regiao 2"
  default = "us-west-2"
}

variable "projeto" {
  description = "Nome do Projeto"
  default = "Atividade1"
}

variable "range_ip" {
  description = "Range IP"
  default = "172.26.0.0/16"
}

variable "subnet_quantidade" {
  description = "quantidade de subnets"
  default = 3
}

variable "quantidade_instancias" {
  description = "quantidade de instancias"
  default = 2
}

variable "key_instance" {
  description = "chave da instancia"
  default = "terraform"
}
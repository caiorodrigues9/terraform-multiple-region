provider "aws" {
  region  = var.regiao1
}

provider "aws" {
  region  = var.regiao2
  alias   = "west"
}
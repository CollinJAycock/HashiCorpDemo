provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-007b092ce28b12ec0"
  instance_type = "t2.micro"

  tags = {
    Name = "HashiCorp_Demo"
  }
}
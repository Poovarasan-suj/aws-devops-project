###---Public-key-Creation---###

resource "aws_key_pair" "web_server_key" {
  key_name   = "web_server_key"
  public_key = file("/home/sujith/.ssh/id_rsa.pub")
  tags = {
    Name = "web_server_key"
  }
}

###---EC-2 Creation----###



resource "aws_instance" "web_server_1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.web_server_key.key_name
  vpc_security_group_ids = [
    var.security_group_id
]
  subnet_id = var.subnet_id
  user_data = file("${path.module}/ec2_1.sh")
  

  tags = {
    Name = "web-server-production"
  }

}
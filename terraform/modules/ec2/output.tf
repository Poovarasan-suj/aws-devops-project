output "instance_id" {
  value = aws_instance.web_server_1.id
}
output "public_ip" {
  value = aws_instance.web_server_1.public_ip
}
output "private_ip" {
  value = aws_instance.web_server_1.private_ip
}
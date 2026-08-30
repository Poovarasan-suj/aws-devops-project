output "vpc_id" {
    value = aws_vpc.project_vpc.id
}

output "subnet_id" {
    value = aws_subnet.Public_subnet.id
}

output "security_group_id" {
    value = aws_security_group.ec2_sg.id
}


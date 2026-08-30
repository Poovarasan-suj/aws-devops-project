####---VPC-Creation---####

resource "aws_vpc" "project_vpc" {
    cidr_block = var.vpc_cidr
}


###---Public_subnet---###

resource "aws_subnet" "Public_subnet" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "devops-Public_subnet"
  }
}

###---Internet-Gateway---###

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project_vpc.id
}




###---Routing--Table---###

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags ={
    Name = "devops-public-route-table"
  }
}

###---subnet Associations---###

resource "aws_route_table_association" "subnet-ass" {
  subnet_id      = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.rt.id
}

###---Security-Group-For-EC2-Instance---###
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "devops-ec2-sg"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "152.57.124.19/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}





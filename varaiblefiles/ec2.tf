resource "aws_security_group" "apache" {
  name        = "apache"
  description = "Allow apache inbound traffic"
  vpc_id = var.vpc_id


  ingress {
    description      = "apache"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 ingress {
    description      = "apache"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "apache_sg"
  }
}
resource "aws_instance" "apache"{
ami= var.ami_id
instance_type= var.instance_type
subnet_id= var.subnetid
vpc_security_group_ids = [aws_security_group.apache.id]

tags = {
  
  Name="apache"
  team="devops"
}
}
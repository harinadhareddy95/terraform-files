
resource "aws_security_group" "apache" {
  name        = "apache"
  description = "Allow apache inbound traffic"


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
ami= data.aws_ami.linux.image_id 
instance_type="t2.micro"
subnet_id= data.aws_subnets.vpc_subnets.ids[1]
vpc_security_group_ids = [aws_security_group.apache.id]

tags = {
  
  Name="apache"
  team="devops"
}
}

provider "aws" {
region = "us-west-2"
}
resource "aws_instance" "one" {
ami = "ami-01e82af4e524a0aa3"
instance_type = "t2.micro"
availability_zone = "us-west-2a"
key_name = "terraform"
vpc_security_group_ids = [aws_security_group.three.id]
user_data = <<EOF
#!/bin/bash
sudo yum install httpd -y
sudo echo "<h1 style='color:green'> This application is high availability server one </h1>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
tags={
Name = "Server-1"
}
}
resource "aws_instance" "two" {
ami = "ami-01e82af4e524a0aa3"
instance_type = "t2.medium"
key_name = "terraform"
availability_zone = "us-west-2b"
vpc_security_group_ids = [aws_security_group.three.id]
user_data=<<EOF
#!/bin/bash
sudo yum install httpd -y
sudo echo "<h1 style='color:blue'> This application is high availability server two </h1>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
tags={
Name = "Server-2"
}
}

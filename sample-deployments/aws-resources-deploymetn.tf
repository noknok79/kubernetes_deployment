provider "aws" {
    region = "us-west-2"  # Replace with your desired region
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_network_interface" "my_nic" {
    subnet_id   = aws_subnet.my_subnet.id
    private_ips = ["10.0.1.10"]
}

resource "aws_security_group" "my_security_group" {
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "my_instance" {
    ami           = "ami-0c94855ba95c71c99"  # Replace with your desired AMI ID
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.my_subnet.id
    security_group_ids = [aws_security_group.my_security_group.id]
}

resource "aws_eip" "my_eip" {
    instance = aws_instance.my_instance.id
}

output "public_ip" {
    value = aws_eip.my_eip.public_ip
}

output "private_ip" {
    value = aws_instance.my_instance.private_ip
}

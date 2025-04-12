provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "tarea_web" {
    name = "tarea_web"
    description = "Permitir SSH y HTTP"

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "tareaTerraformContainer" {
    ami = "ami" # cambiar valor de ami
    instance_type = "t2.micro"
    key_name = "vockey"

    vpc_security_group_ids = [aws_security_group.tarea_web.id]

    root_block_device {
      volume_size = 20
      volume_type = "gp2"
    }

    tags = {
        Name = "InstanciaConTerraform"
    }
}
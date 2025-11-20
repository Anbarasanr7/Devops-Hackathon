provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "devops_ec2" {
  ami           = "ami-0e6329e222e662a52"   # Amazon Linux 2023
  instance_type = "t2.micro"
  key_name      = "my-key"

user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

docker pull <docker_username>/patient-service:v1
docker run -d -p 3000:3000 --name patient-service <docker_username>/patient-service:v1

docker pull <docker_username>/appointment-service:v1
docker run -d -p 3001:3001 --name appointment-service <docker_username>/appointment-service:v1
EOF

  tags = {
    Name = "DevOpsMicroservices"
  }
}

output "ec2_public_ip" {
  value = aws_instance.devops_ec2.public_ip
}

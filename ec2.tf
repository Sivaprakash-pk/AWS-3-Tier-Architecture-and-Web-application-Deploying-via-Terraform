
resource "aws_instance" "web" {
  ami           = "ami-0287a05f0ef0e9d9a"
  instance_type = "t2.micro"
  key_name = "KP1-M"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo apt update -y
                  sudo apt install docker.io -y
                  sudo systemctl start docker
                  sudo usermod -aG docker ubuntu
                  sudo chmod 777 /var/run/docker.sock
                  sudo docker run -dit -p 80:80 --name webapp1 sivaprakash1998/web-app-nginx-test-server1:v1
                  EOF

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "D:\KP1-M.pem"
    destination = "/home/ubuntu/KP1-M.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = "${file("./KP1-M.pem")}"
    }  
  }
}

resource "aws_instance" "db" {
  ami           = "ami-08df646e18b182346"
  instance_type = "t2.micro"
  key_name = "KP1-M"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}

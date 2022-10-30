resource "aws_security_group" "mlflow_group" {
  name        = "mlflow_group"
  description = "Allow inbound and outbound traffic to mlflow server"
  vpc_id      = aws_vpc.dev.id

  # Allow all SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dev EC2 security group"
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "SSH Key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}


resource "aws_instance" "web_server" {
  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = aws_subnet.dev_subnet_a.id
  vpc_security_group_ids      = [aws_security_group.mlflow_group.id]
  associate_public_ip_address = true
  user_data = templatefile("mlflow_env_setup.tftpl", {
    db_user = var.db_user,
    db_password = var.db_password,
    db_url = aws_db_instance.mlflow_db.address
    database = aws_db_instance.mlflow_db.db_name
    bucket = aws_s3_bucket.mlbucket.bucket
  })

  tags = {
    Name = "MlflowInstance"
  }
}

output "ssh_private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}
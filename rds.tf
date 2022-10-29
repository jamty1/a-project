resource "aws_security_group" "rds_group" {
  name        = "rds_group"
  description = "Allow inbound and outbound traffic to the database"
  vpc_id      = aws_vpc.dev.id

  # Allow all MySQL traffic
  ingress {
    from_port   = 3306
    to_port     = 3306
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
    Name = "Dev RDS security group"
  }
}

resource "aws_db_parameter_group" "mysql_group" {
  name   = "rds-mysql"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
}

resource "aws_db_subnet_group" "db_group" {
  name       = "mlflow_db_group"
  subnet_ids = [aws_subnet.dev_subnet_b.id, aws_subnet.dev_subnet_c.id]

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "mlflow_db" {
  allocated_storage    = 10
  db_name              = "mlflow_db"
  db_subnet_group_name = aws_db_subnet_group.db_group.name
  vpc_security_group_ids = [aws_security_group.rds_group.id]
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "rds-mysql"
  skip_final_snapshot  = true
}
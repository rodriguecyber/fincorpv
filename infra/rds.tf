resource "aws_db_instance" "primary" {
  identifier          = "fincorp-db-instance"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_name             = "fincorp"
  publicly_accessible = true
  username            = "rwigara"
  password            = "yourpassword"
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot = true
}

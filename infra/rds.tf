resource "aws_db_instance" "primary" {
  identifier         = "fincorp-db-instance"
  engine             = "postgres"
  instance_class     = "db.t3.micro"
  allocated_storage = 20
  publicly_accessible = true
  username           = "rwigara"
  password           = "yourpassword"
  skip_final_snapshot = true
}

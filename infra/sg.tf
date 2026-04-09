resource "aws_security_group" "rds" {
  name = "rds_sg"
  
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
  }
  
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  
  }
}
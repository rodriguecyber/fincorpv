resource "aws_ecr_repository" "fincorp" {
  name = "fincorp-repository"
  image_tag_mutability = "IMMUTABLE"

image_scanning_configuration {
  scan_on_push = true
}
}
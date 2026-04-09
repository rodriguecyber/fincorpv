resource "aws_codeartifact_domain" "fincorp" {
  domain = "fincorp-domain"
}
resource "aws_codeartifact_repository" "fincorp" {
  repository = "fincorp-repository"
  domain     = aws_codeartifact_domain.fincorp.domain 
}
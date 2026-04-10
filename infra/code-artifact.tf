resource "aws_codeartifact_domain" "fincorp" {
  domain = "fincorp-domain"
}


resource "aws_codeartifact_repository" "npm_upstream" {
  repository = "npm-upstream"
  domain     = aws_codeartifact_domain.fincorp.domain

  external_connections {
    external_connection_name = "public:npmjs"
  }
}

resource "aws_codeartifact_repository" "fincorp" {
  repository = "fincorp-repository"
  domain     = aws_codeartifact_domain.fincorp.domain

  upstream {
    repository_name = aws_codeartifact_repository.npm_upstream.repository
  }
}
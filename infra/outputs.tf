output "ecr_repository_url" {
  value       = aws_ecr_repository.fincorp.repository_url
  description = "ECR repository URL for pushing images."
}

output "codeartifact_domain" {
  value       = aws_codeartifact_domain.fincorp.domain
  description = "CodeArtifact domain name."
}

output "codeartifact_repository" {
  value       = aws_codeartifact_repository.fincorp.repository
  description = "Internal CodeArtifact repository name."
}

output "primary_region" {
  value       = "us-east-1"
  description = "Primary region."
}

output "dr_region" {
  value       = "us-west-2"
  description = "Disaster recovery region."
}

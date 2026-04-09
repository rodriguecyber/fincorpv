resource "aws_backup_vault" "primary" {
  name = "fincorp-backup-vault"
}

resource "aws_backup_vault" "secondary" {
  provider = aws.north
  name     = "fincorp-backup-vault-secondary"

}

resource "aws_backup_plan" "plan" {
  name = "fincorp-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = "cron(0 12 * * ? *)" # Daily at 12:00 PM UTC

    lifecycle {
      delete_after = 7
    }
    copy_action {
      destination_vault_arn = aws_backup_vault.secondary.arn
      lifecycle {
        delete_after = 7
      }
    }
  }
  
}

resource "aws_backup_selection" "rds" {
  name         = "fincorp-rds-backup-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.plan.id
  resources = [
    aws_db_instance.primary.arn
  ]
}

resource "aws_iam_role" "backup_role" {
  name = "fincorp-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_role_backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "backup_role_restore_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

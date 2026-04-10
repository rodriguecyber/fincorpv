## FinCorp: Secure supply chain + Cross-Region DR

### Artifact pipeline (immutable artifacts)

- **CodeArtifact upstream proxy**: `npm-upstream` → `public:npmjs`, plus an internal repo `fincorp-repository` with an upstream to it.
- **ECR**: `image_tag_mutability = "IMMUTABLE"` and `scan_on_push = true`.
- **CI gate**: `.github/workflows/ci-cd.yml` pushes an image tagged by commit SHA and **fails** if ECR reports **HIGH** or **CRITICAL** findings.

### DR (RDS + AWS Backup Cross-Region Copy)

- **Primary DB**: `us-east-1` (`aws_db_instance.primary`)
- **Backups**: AWS Backup plan runs **daily** and copies recovery points to **us-west-2** via the `aws.west` provider.

### DR simulation runbook (CLI)

Assumes you already applied Terraform and have AWS credentials with permissions for RDS + Backup.

1. **Verify copied recovery points exist in `us-west-2`**:

```bash
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name fincorp-backup-vault-secondary \
  --region us-west-2
```

2. **Simulate “region failure”** by deleting the primary DB in `us-east-1`:

```bash
aws rds delete-db-instance \
  --db-instance-identifier fincorp-db-instance \
  --skip-final-snapshot \
  --region us-east-1
```

3. **Restore in `us-west-2` from the copied recovery point** (pick a `RecoveryPointArn` from step 1):

```bash
aws backup start-restore-job \
  --recovery-point-arn "<RecoveryPointArn>" \
  --iam-role-arn "<AWSBackupDefaultServiceRole-or-your-backup-role-arn>" \
  --metadata '{
    "DBInstanceIdentifier":"fincorp-db-instance-dr",
    "DBInstanceClass":"db.t3.micro",
    "Engine":"postgres",
    "AllocatedStorage":"20",
    "PubliclyAccessible":"false"
  }' \
  --region us-west-2
```

4. **Confirm the restored DB exists**:

```bash
aws rds describe-db-instances \
  --db-instance-identifier fincorp-db-instance-dr \
  --region us-west-2
```


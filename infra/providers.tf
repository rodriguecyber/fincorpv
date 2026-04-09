provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "north"
  region = "eu-north-1"
}

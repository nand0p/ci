terraform {
  backend "s3" {
    bucket  = "hex7-cicd"
    key     = "terraform_state/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

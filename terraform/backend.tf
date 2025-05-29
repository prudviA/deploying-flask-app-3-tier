terraform {
  backend "s3" {
    bucket         = "terraform-state-prudvi789654"
    key            = "eks/devsecops/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

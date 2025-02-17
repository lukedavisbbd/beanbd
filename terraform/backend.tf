terraform {
  backend "s3" {
    bucket  = "beanbd-db-tfstate"
    key     = "beanbd-db/beanbd.tfstate"
    region  = "af-south-1"
    encrypt = true
  }
}

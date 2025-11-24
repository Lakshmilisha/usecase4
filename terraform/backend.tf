terraform {
  backend "gcs" {
    bucket = "usecase4-dev-tfstate"
    prefix = "terraform/state"
  }
}
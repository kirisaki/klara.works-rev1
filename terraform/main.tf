terraform {
  backend "gcs" {
    bucket = "klaraworks-tfstate"
    prefix   = "klaraworks"
    credentials = "klaraworks-tfstate.json"
  }
}

provider "google-beta" {
  credentials = file("klaraworks-deploy-dev.json")
  project     = var.project_dev
  region      = var.region
  version     = "~> 3.14.0"
  alias       = "dev"
}


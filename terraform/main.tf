terraform {
  backend "gcs" {
    bucket = "klaraworks-tfstate"
    prefix   = "klaraworks"
    credentials = "klaraworks-tfstate.json"
  }
}

provider "google-beta" {
  credentials = local.credential
  project     = local.project
  region      = var.region
  version     = "~> 3.14.0"
}


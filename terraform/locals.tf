locals {
    project = var.project[terraform.workspace]
    credential = local.credentials[terraform.workspace]
    credentials = {
        dev = file("klaraworks-deploy-dev.json")
    }
}
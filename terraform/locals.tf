locals {
    k = terraform.workspace
    name = "klaraworks-${local.k}"
    project = var.project[local.k]
    domain = var.domain[local.k]
    credential = file(local.credentials[local.k])
    credentials = {
        dev = "klaraworks-deploy-dev.json"
    }
}
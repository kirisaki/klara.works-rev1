locals {
    k = terraform.workspace

    name = "klaraworks-${local.k}"

    project = var.project[local.k]

    domain = var.domain[local.k]

    credential = file({
        dev = "klaraworks-deploy-dev.json"
    }[local.k])
}

locals {
    branch = {
        dev = "develop"
    }[local.k]
}

locals {
    normal_nodes = {
        dev = 1
    }[local.k]

    normal_node_type = {
        dev = "e2-micro"
    }[local.k]

    preemptible_nodes = {
        dev = 1
    }[local.k]

    preemptible_node_type = {
        dev = "e2-micro"
    }[local.k]

    scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
     ]
}
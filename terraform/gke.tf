resource "google_container_cluster" "primary"{
  name = local.name
  provider = google-beta
  project = local.project
  location = var.zone

  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name = "${local.name}-normal"
  provider = google-beta
  project = local.project
  location = var.zone
  cluster = google_container_cluster.primary.name
  node_count = local.normal_nodes

  management {
    auto_repair = true
  }

  node_config {
    machine_type = local.normal_node_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = local.scopes
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${local.name}-preemptible"
  provider = google-beta
  project = local.project
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = local.preemptible_nodes

  management {
    auto_repair = true
  }

  node_config {
    preemptible  = true
    machine_type = local.preemptible_node_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = local.scopes
  }
}
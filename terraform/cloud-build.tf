resource "google_cloudbuild_trigger" "ci" {
  provider = google-beta
  project = local.project
  name = terraform.workspace

  substitutions = {
    _NAME = local.name
    _CLUSTER = google_container_cluster.primary.name
    _ZONE = google_container_cluster.primary.location
    _WEB_USER = var.web_user
    _WEB_PASSWORD = var.web_password
  }

  github {
    owner = var.owner
    name = var.repo
    push {
      branch = local.branch
    }
  }
  filename = "cloudbuild-${terraform.workspace}.yaml"
}

resource "google_storage_bucket" "cache" {
  provider = google-beta
  name = "${local.name}-cache"
  project = local.project
  location = var.region
}

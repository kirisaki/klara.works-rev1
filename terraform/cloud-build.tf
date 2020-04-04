resource "google_cloudbuild_trigger" "ci" {
  provider = google-beta
  project = local.project
  name = terraform.workspace
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
resource "google_compute_global_address" "static" {
  name = "prototip-2"
  project = local.project
  provider = google-beta
}

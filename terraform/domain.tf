resource "google_compute_global_address" "static" {
  name = local.name
  project = local.project
  provider = google-beta
}

resource "google_dns_managed_zone" "zone" {
  name = local.name
  project = local.project
  provider = google-beta
  dns_name = "${local.domain}."
}

resource "google_dns_record_set" "a" {
  name = google_dns_managed_zone.zone.dns_name
  project = local.project
  provider = google-beta
  managed_zone = google_dns_managed_zone.zone.name
  type = "A"
  ttl = 300
  rrdatas = [google_compute_global_address.static.address]
}

resource "google_dns_record_set" "caa" {
  name = google_dns_managed_zone.zone.dns_name
  project = local.project
  provider = google-beta
  managed_zone = google_dns_managed_zone.zone.name
  type = "CAA"
  ttl = 300
  rrdatas = ["0 issue \"letsencrypt.org\"", "0 issue \"pki.goog\""]
}

resource "google_dns_record_set" "mx" {
  name = google_dns_managed_zone.zone.dns_name
  project = local.project
  provider = google-beta
  managed_zone = google_dns_managed_zone.zone.name
  type = "MX"
  ttl = 3600
  rrdatas = [
            "1 aspmx.l.google.com.",
            "5 alt1.aspmx.l.google.com.",
            "5 alt2.aspmx.l.google.com.",
            "10 alt3.aspmx.l.google.com.",
            "10 alt4.aspmx.l.google.com."
            ]
}

resource "google_dns_record_set" "txt" {
  name = google_dns_managed_zone.zone.dns_name
  project = local.project
  provider = google-beta
  managed_zone = google_dns_managed_zone.zone.name
  type = "TXT"
  ttl = 3600
  rrdatas = ["\"google-site-verification=ibp2ku_I1LU7SjneCJ3VQ2SSPShkhFN0Q9tBd71yChk\""]
}

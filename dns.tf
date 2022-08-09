terraform {
    required_providers {
    google = {
      source = "hashicorp/google"
      version = "~>4.16.0"
    }
  }
}

provider "google" {
  project = "skilful-reserve-349011"
  region  = "us-central1"
  zone    = "us-central1-c"
}


#=======================================================================

data "google_compute_network" "high" {
  name = "default"
  project = "skilful-reserve-349011"
}

resource "google_dns_managed_zone" "private-zone" {
  name        = "private-zone"
  dns_name    = "private.example.com."
  description = "Example private DNS zone"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = data.google_compute_network.high.id
    }
  }
}

resource "google_dns_record_set" "a" {
  name         = "backend.${google_dns_managed_zone.private-zone.dns_name}"
  managed_zone = google_dns_managed_zone.private-zone.name
  type         = "A"
  ttl          = 3

  rrdatas = ["8.8.8.8"]
}
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


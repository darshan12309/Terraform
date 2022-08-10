#---------------------------------------------------MIG-------------------------------------------------------
resource "google_compute_instance_template" "instance_template" {
  project      = "skilful-reserve-349011"

  name         = "test"
  machine_type = "n1-standard-2"
  region       = "us-central1"

  // boot disk
  disk {
    source_image      = "image-1"
    auto_delete       = true
    boot              = true
  }


  network_interface {
      network             = "default"
    }

  lifecycle {
    create_before_destroy = true
  }

}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  project      = "skilful-reserve-349011"

  name               = "test"
  base_instance_name = "test"
  zone               = "us-central1-a"
  target_size        = 2

  version {
    instance_template  = google_compute_instance_template.instance_template.id
  }
}

resource "google_compute_autoscaler" "mig_autoscaler" {
  provider = google-beta
  project      = "skilful-reserve-349011"

  name   = "test"
  zone   = "us-central1-a"
  target = google_compute_instance_group_manager.instance_group_manager.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.7
    }
  }
}
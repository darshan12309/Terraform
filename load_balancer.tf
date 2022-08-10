resource "google_compute_region_health_check" "nginx_health_check" {
  provider = google-beta
  project      = "skilful-reserve-349011"

  name                = "tests"
  region                = "us-central1"
  timeout_sec         = 60
  check_interval_sec  = 60
  healthy_threshold   = 1
  unhealthy_threshold = 1
  
  
  tcp_health_check {
    port = 8080
  } 
}

# backend service
resource "google_compute_region_backend_service" "lb_backend" {
  provider              = google-beta
  project      = "skilful-reserve-349011"

  name                  = "tests"
  region                = "us-central1"
  protocol              = "TCP"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_region_health_check.nginx_health_check.id]
  backend {
    group           = google_compute_instance_group_manager.instance_group_manager.instance_group
    balancing_mode  = "CONNECTION"
  }
} 

resource "google_compute_forwarding_rule" "lb_frontend" {
  project      = "skilful-reserve-349011"

  name                  = "tests"
  region                = "us-central1"
  load_balancing_scheme = "EXTERNAL"
  backend_service       = google_compute_region_backend_service.lb_backend.id
  ports                 = [8080 , 8081]
} 

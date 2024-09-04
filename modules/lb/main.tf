# Static IP for the load balancer
resource "google_compute_global_address" "this" {
  name = "${var.name}-lb-ip"
}

# URL Map
resource "google_compute_url_map" "this" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.this.id
}

# Target HTTP Proxy
resource "google_compute_target_http_proxy" "this" {
  name   = "${var.name}-http-lb-proxy"
  url_map = google_compute_url_map.this.id
}

# Forwarding Rule
resource "google_compute_global_forwarding_rule" "this" {
  name        = "${var.name}-http-forwarding-rule"
  ip_address  = google_compute_global_address.this.address
  port_range  = "80"
  target      = google_compute_target_http_proxy.this.id
}

# Create a health check
resource "google_compute_http_health_check" "this" {
  name               = "${var.name}-http-health-check"
  request_path       = "/"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 3
}

# Backend service
resource "google_compute_backend_service" "this" {
  name                  = "${var.name}-backend-service"
  port_name             = "http"
  protocol              = "HTTP"
  health_checks         = [google_compute_http_health_check.this.id]
  load_balancing_scheme = "EXTERNAL"

  dynamic "backend" {
    for_each = var.backend
    content {
      group = contains(keys(backend.value), "group") ? backend.value["group"]: null 
    }
  }
}
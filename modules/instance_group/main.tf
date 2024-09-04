resource "google_compute_instance_group" "this" {
  name        = var.name
  zone        = var.zone
  instances   = var.instances
  dynamic named_port {
    for_each = var.named_port != null ? var.named_port : []
    content {
      name = contains(keys(named_port.value), "name") ? named_port.value["name"] : null
      port = contains(keys(named_port.value), "port") ? named_port.value["port"] : null
    }
  }
}



resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  dynamic boot_disk {
    for_each = var.boot_disk
    content {
        dynamic initialize_params {
        for_each = contains(keys(boot_disk.value.initialize_params[0]), "image") ? boot_disk.value.initialize_params : []
            content {
                image = initialize_params.value["image"]
            }
        }
    }
  }

  dynamic network_interface {
    for_each = var.network_interface
    content {
        network = "default"  
        access_config {
        # Ephemeral public IP
        }
    }
  }

  tags = var.tags
  metadata_startup_script = file(var.init_script_path)
  allow_stopping_for_update = true

  dynamic "service_account" {
    for_each = var.service_account
    content {
      email = contains(keys(service_account.value), "email") ? service_account.value.email : null
      scopes = contains(keys(service_account.value), "scopes") ? service_account.value.scopes : ["cloud-platform"]
    }
  }
}
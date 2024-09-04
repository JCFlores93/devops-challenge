variable "name" {
  type = string
  description = "The name of the vm."
}

variable "machine_type" {
  type = string
  description = "The name of the vm."
}

variable "zone" {
  type = string
  description = "The name of the vm."
}

variable "init_script_path" {
  type = string
  description = "Path where is located the script."
}

variable "boot_disk" {
  type = list
  description = "Configuration for boot_disk"
  default = []
}

variable "network_interface" {
  type = list
  description = "Configuration for boot_disk"
  default = []
}

variable "tags" {
  type = list(string)
  default = []
}

variable "service_account" {
  type = list
  default = []
}

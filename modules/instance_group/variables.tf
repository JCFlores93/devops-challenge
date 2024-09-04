variable "name" {
  type = string
  description = "The name of the instace group."
}

variable "zone" {
  type = string
  description = "The name of the instance group."
}

variable "instances" {
  type = list
  description = "Configuration for boot_disk"
}

variable "named_port" {
  type = list
  description = "Configuration for boot_disk"
}

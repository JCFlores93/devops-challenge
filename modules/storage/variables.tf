variable "name" {
  type = string
  description = "The name of the instace group."
}

variable "location" {
  type = string
  description = "The name of the instance group."
  default = "US"
}

variable "admin_members" {
  type = map
  default = {}
}
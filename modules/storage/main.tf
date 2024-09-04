resource "google_storage_bucket" "this" {
  name     = var.name
  location = var.location
}

resource "google_storage_bucket_iam_member" "this" {
  for_each = var.admin_members
  bucket = google_storage_bucket.this.name
  role = "roles/storage.admin"
  member = "serviceAccount:${each.value}"
}
# storage.tf
resource "random_string" "random_bucket_suffix" {
  length = 5
  special = false
  upper = false
  override_special = "/@$"
}

module "storage_test_logs_bucket" {
  source = "../../modules/storage"
  name = "test-logs-bucket-${random_string.random_bucket_suffix.result}"
  location = "US"
  admin_members = {
    "test_web_server_1": google_service_account.test_sa_web_server_1.email,
    "test_web_server_2": google_service_account.test_sa_web_server_2.email,
  }
}
resource "google_service_account" "test_sa_web_server_1" {
  account_id   = "test-sa-web-server-1"
  display_name = "test-sa-web-server-1"
}

resource "google_service_account" "test_sa_web_server_2" {
  account_id   = "test-sa-web-server-2"
  display_name = "test-sa-web-server-2"
}
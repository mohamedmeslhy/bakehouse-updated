terraform {
  backend "gcs" {
    bucket  = "bucket_gke_test"
    prefix  = "terraform/state"
  }
}
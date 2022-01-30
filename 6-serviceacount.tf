# resource "google_service_account" "sa_vm" {
#   account_id   = "service-acount-for-vm-project"
#   display_name = "service-acount-for-vm-project"
# }



# resource "google_project_iam_binding" "sa_vm" {
#   project = "abdelrahman-saeed"
#   role    = "roles/container.admin"
#   depends_on = [
#     google_service_account.sa_vm
#   ]
#   members = [
#     "serviceAccount:${google_service_account.sa_vm.email}"
#   ]
# }





resource "google_service_account" "sa_gke" {
  account_id   = "service-acount-for-gke-project"
  display_name = "service-acount-for-gke-project"
}



resource "google_project_iam_binding" "sa_gke" {
  project = "active-sun-337308"
  role    = "roles/container.admin"
  depends_on = [
    google_service_account.sa_gke
  ]
  members = [
    "serviceAccount:${google_service_account.sa_gke.email}"
  ]
}

resource "google_project_iam_binding" "sa_gke1" {
  project = "active-sun-337308"
  role    = "roles/storage.admin"
  depends_on = [
    google_service_account.sa_gke
  ]
  members = [
    "serviceAccount:${google_service_account.sa_gke.email}"
  ]
}


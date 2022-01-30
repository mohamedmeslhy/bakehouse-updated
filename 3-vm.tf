resource "google_compute_instance" "private_vm" {
  name         = "ssh-vm"
  machine_type = var.vm_type
  zone         = "${var.regoin}-a"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  depends_on = [
    # google_service_account.sa_vm,
    google_compute_subnetwork.public_subnet
  ]
  network_interface {
    network = var.network_name
    subnetwork = var.public_subnet_name
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "490760045727-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

}
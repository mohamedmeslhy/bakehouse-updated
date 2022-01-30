resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.regoin
  network = var.network_name
  subnetwork = var.private_subnet_name
  depends_on = [google_compute_subnetwork.private_subnet]

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.0.0/16"
      display_name = "net1"
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    master_global_access_config {
      enabled = false
      
    }

  }  
    ip_allocation_policy {
    cluster_ipv4_cidr_block = "10.2.0.0/16" 
    services_ipv4_cidr_block = "10.3.0.0/16"
    
  }
  
}

resource "google_container_node_pool" "project_pool" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    service_account = google_service_account.sa_gke.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    }

   
}
resource "google_compute_network" "vpc_network" {
  name = var.network_name
  auto_create_subnetworks = false
}

# public subnet

resource "google_compute_subnetwork" "public_subnet" {
name = var.public_subnet_name
ip_cidr_range = "10.0.0.0/16"
region = var.regoin
network = var.network_name
depends_on = [google_compute_network.vpc_network]
}

# private subnet
resource "google_compute_subnetwork" "private_subnet" {
name = var.private_subnet_name
ip_cidr_range = "10.1.0.0/16"
region = var.regoin
network = var.network_name
depends_on = [google_compute_network.vpc_network]
}

# router 
resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.regoin
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

# NAT
resource "google_compute_router_nat" "nat" {
  name                               = var.nat_cloud
  router                             = google_compute_router.router.name
  region                             = var.regoin
  nat_ip_allocate_option             = "AUTO_ONLY"
  depends_on = [google_compute_subnetwork.public_subnet]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.public_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }


}

# firewall

resource "google_compute_firewall" "rules" {
  project     = var.project_name
  name        = "allowtcprules"
  network     = var.network_name
  depends_on = [google_compute_network.vpc_network]

  allow {
    protocol  = "tcp"
    ports     = ["80", "22", "443", "8080", "50000"]
  }

  source_ranges = ["35.235.240.0/20"]
}

# router 
resource "google_compute_router" "router2" {
  name    = "router2"
  region  = var.regoin
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

# NAT
resource "google_compute_router_nat" "nat2" {
  name                               = "nat2"
  router                             = google_compute_router.router.name
  region                             = var.regoin
  nat_ip_allocate_option             = "AUTO_ONLY"
  depends_on = [google_compute_subnetwork.private_subnet]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }


}
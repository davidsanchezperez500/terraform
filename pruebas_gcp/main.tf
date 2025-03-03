provider "google" {
  credentials = file("/home/david/Downloads/TFM-BIGDATA-93784c0f4f61.json")

  project = "tfm-bigdata-267615"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }


  network_interface {
  network = google_compute_network.vpc_network.self_link
  access_config {
    nat_ip = google_compute_address.vm_static_ip.address
  }
}
}
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

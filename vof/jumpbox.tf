resource "google_compute_instance" "vof-jumpbox" {
  name         = "${var.env_name}-jumpbox"
  machine_type = "${var.machine_type}"
  zone = "${var.zone}"

  tags = ["${var.env_name}-jumpbox"]

  boot_disk {
    initialize_params {
      image = "${var.base_image}"
    }
  }

  network_interface {
    network = "${google_compute_network.vof-network.name}"
    access_config {}
  }

  metadata {
    serviceAccountEmail = "${var.service_account_email}"
    serial-port-enable = 1
  }

  service_account {
    email = "${var.service_account_email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_firewall" "vof_jumpbox_firewall" {
  name = "${var.env_name}-vof-jumpbox-firewall"
  network = "${google_compute_network.vof-network.name}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["${var.env_name}-jumpbox"]
}
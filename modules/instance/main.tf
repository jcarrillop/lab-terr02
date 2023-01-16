

locals {
  network = "${element(split("-", var.subnet), 0)}"
  
}

resource "google_compute_instance" "prueba-vmimage" {
  project      = "${var.project}"
  zone         = "us-west1-a"
  name         = "${local.network}-prueba-vmimage"
  machine_type = "f1-micro"

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<html><body><h1>Environment: ${local.network}</h1></body></html>' | sudo tee /var/www/html/index.html"


  boot_disk {
    initialize_params {
            image = "https://www.googleapis.com/compute/v1/projects/neptuno-23/global/images/image-1"
            #image = "https://www.googleapis.com/compute/v1/projects/daxos-recaptcha/global/images/img-prueba02"
    }
  }

  /* boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  } */

  network_interface {
    subnetwork = "${var.subnet}"
        
    access_config {
      # Include this section to give the VM an external ip address
    }
  }

  # Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server", "ssh-connect"]
}


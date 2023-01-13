# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


locals {
  network = "${element(split("-", var.subnet), 0)}"

}

/* resource "google_compute_instance" "http_server" {
  project      = "${var.project}"
  zone         = "us-west1-a"
  name         = "${local.network}-apache2-instance"
  machine_type = "f1-micro"

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<html><body><h1>Environment: ${local.network}</h1></body></html>' | sudo tee /var/www/html/index.html"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = "${var.subnet}"

    access_config {
      # Include this section to give the VM an external ip address
    }
  }

  # Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server", "ssh-connect"]
} */


locals {
  network = "${element(split("-", var.subnet), 0)}"
  
}

resource "google_compute_instance" "prueba-vmimage" {
  boot_disk {
    auto_delete = true
    device_name = "vm-prueba01"

    initialize_params {
      size = 10
      type = "pd-balanced"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/daxos-recaptcha/zones/us-east1-b/disks/prueba02-16"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  labels = {
    project = "${var.project}"
  }

  machine_type = "e2-micro"

  /* metadata = {
    ssh-keys = "javier_carrillo:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBO8PlOzrhCa2EzicQHE8r52rc6j6mxjGRk/SnO3s2dg0hPIq47x1lyTABIgeCY1xCplKX9+NYde+SZY8CWTOANI= google-ssh {\"userName\":\"javier.carrillo@daxosline.com.co\",\"expireOn\":\"2022-12-16T19:59:22+0000\"}\njavier_carrillo:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAFyonIyAKrTtkiMPIcDJ+68WjblY8sltepVVjVUt6JAtO0xxmVcLi/1iiPJN1oy1ZZ86JBVvCQW3AgZ0ExwrCptQpXZPlE1qbKEBJwDrP8kQJsHNqwlVWsW/ByiOineopoDCS9t1KLwcL+PKAbkla0UEyVsInr/y3WWL6/ZQw4nkZaTxBeN/o/53dC53ejOyLZjwixlpHDxpMcbGhakALc4a+djPcKgiiWvoGC/zLJBnaITVyPG2XTEvlpDImEMN8xK3SkSKXdp55KyhMDrG9bHQ1hVsf48O6WYeXtjfbww9WOih7STq3s/EZoml5+gh5kcBEBAflqyYKhS+2rZMQy0= google-ssh {\"userName\":\"javier.carrillo@daxosline.com.co\",\"expireOn\":\"2022-12-16T19:59:37+0000\"}"
  } */

  name = "prueba02-16"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    network            = "${var.env}"
    network_ip         = "10.10.10.5"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "${var.subnet}"
    subnetwork_project = "${var.project}"
  }


  project = "${var.project}"

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  /* scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  } */

  /* service_account {
    email  = "558254534793-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  } */

  /* shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  } */

  zone = "us-west1-a"
  tags = ["icmp", "ssh-connect"]
}

resource "google_compute_machine_image" "prueba-vmimage" {
  disk_size_gb = 10

  guest_os_features {
    type = "GVNIC"
  }

  guest_os_features {
    type = "UEFI_COMPATIBLE"
  }

  guest_os_features {
    type = "VIRTIO_SCSI_MULTIQUEUE"
  }

  licenses    = ["https://www.googleapis.com/compute/v1/projects/debian-cloud/global/licenses/debian-11-bullseye"]
  name        = "img-0217-prueba"
  project     = "daxos-recaptcha"
  source_disk = "https://www.googleapis.com/compute/v1/projects/daxos-recaptcha/zones/us-central1-c/disks/prueba02-17"
}
# terraform import google_compute_instance.prueba02_16 projects/daxos-recaptcha/zones/us-east1-b/instances/prueba02-16

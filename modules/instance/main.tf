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

resource "google_compute_instance" "prueba-vmimage" {
  provider = google-beta
  name     = "prueba-vmimage"
  zone     = "us-west1-a"
  project = "${var.project}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
            image = ""
    }
  }

  network_interface {
   subnetwork = "${var.subnet}"

       access_config {
      # Include this section to give the VM an external ip address
    }
  }
}
  metadata = {
    block-project-ssh-keys = true
    }

resource "google_compute_machine_image" "image" {
  provider          = google-beta
  project           = "${var.project}"
  name              = "image-1"
  source_instance   = "https://www.googleapis.com/compute/v1/projects/daxos-recaptcha/global/images/img-prueba02"
  
}

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

resource "google_compute_instance_from_machine_image" "prueba-vmimage" {
  provider = google-beta
  name     = "prueba-vmimage"
  zone     = "us-west1-a"
  project = "${var.project}"

  source_machine_image = "projects/daxos-recaptcha/global/machineImages/img-prueba02"

  confidential_instance_config {
    enable_confidential_compute = false
  }

  labels = {
    project = "${var.project}"
  }

  machine_type = "e2-micro"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    #network            = "${var.env}"
    network_ip         = "10.10.10.5"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "${var.subnet}"
    subnetwork_project = "${var.project}"
  }

  tags = ["icmp", "ssh-connect"]

  

  reservation_affinity {
    type = "ANY_RESERVATION"
  }
}


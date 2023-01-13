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
            image = "https://www.googleapis.com/compute/v1/projects/daxos-recaptcha/global/images/img-prueba02"
    }
  }

  network_interface {
   network    = dev
   subnetwork = "${var.subnet}"

       access_config {
      # Include this section to give the VM an external ip address
    }
  }

    metadata = {
    ssh-keys = "javier.carrillo:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBC4stPOY10fTp7hJpiUSzwuC70mxSs9RV9vsEqv8CPOmA+7Q3SgwhMdhXTS24e79v1wtHG7fUQMIQePI4oHKh9c= google-ssh {\"userName\":\"javier.carrillo@daxosline.com.co\",\"expireOn\":\"2022-12-16T21:16:45+0000\"}\njavier.carrillo:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdWMqmmIPXrXlx4cNJpNXrK2Ir6KFrmhSKYIbU/wEKmHaoeqifVZU1RmdDiGBgqTZ2VFOoGBNIjf/S6xaSlORqWhGpalOHP9UK63LnXlVioDGzrmHLie5WVd7TE5OBTo0TBl3A43XD5VmkBWOdT9a2WEd2JcvP00VaIfCCEBRh0TtzaOlJtM9NspQ7GJ/Bg4F/vhVgsw01ElBkJmCW/OxLBb4NtjyLMwBh8RSOM+Ew7FOMXvH/W3w4H2uS1uNzbMIH9DOM7Yry2FHsUtV9LGl2C5Zs6RLi2RWyCgg/WFiSzEp3UCte1piSzi0zXtwjcg4kmb8vkCAKwObUKshBg2zp google-ssh {\"userName\":\"javier.carrillo@daxosline.com.co\",\"expireOn\":\"2022-12-16T21:17:01+0000\"}\ntriton21:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfTcYG/UsXRLr7X3yeTLCzWNhtKruQCFeVbByNUx/SzX9AnVXT3nkG0NqMn1wWSiaZ/FommYZ/eJNCS8okZsG6sSfMQjOLF2PzarH84zgujVC1fw5RM/1C9RjJsAF/KBBCgiNuPaYPMdT4oxsS2NVk4z7R6s6oM9SngVNW0eork+KhJP3rbelosZeiG6wDC9lwI+sIp0JJk0bNA91DdmzZihiy5dlbQKHC9FmVV/TsUTqog8SgnOsPmVhVFH7M1pZvHyvBgUhuw4Sya++0vIOWkzpbZJLP6fGdovW0iBF3XhHWf9gaZ/sQhASfghiYTMZQus2N+ID0NLIXO/A3MuLh triton21"
  }
}


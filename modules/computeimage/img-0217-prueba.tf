resource "google_compute_image" "img_0217_prueba" {
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
# terraform import google_compute_image.img_0217_prueba projects/daxos-recaptcha/global/images/img-0217-prueba

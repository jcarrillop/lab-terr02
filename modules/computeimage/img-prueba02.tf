resource "google_compute_image" "img_prueba02" {
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
  name        = "img-prueba02"
  project     = "daxos-recaptcha"
  source_disk = "https://www.googleapis.com/compute/v1/projects/daxos-recaptcha/zones/us-east1-b/disks/prueba02-16"
}
# terraform import google_compute_image.img_prueba02 projects/daxos-recaptcha/global/images/img-prueba02

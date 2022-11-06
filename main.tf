resource "google_compute_instance" "vm-from-tf" {
  name = "vm-from-tf"
  zone = "asia-southeast1-a"
  machine_type = "n1-standard-2"
  allow_stopping_for_update = true

  network_interface {
    network = "custom-vpc"
    subnetwork = "sub-sg"
  }

  boot_disk {
    initialize_params {
      image = "centos-stream-8-v20220920"
      size = "25"
    }

    auto_delete = true
  }

  labels = {
    "env" = "tflearning"
  }

  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }
}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = "15"
  type = "pd-ssd"
  zone = "asia-southeast1-a"
}

resource "google_compute_attached_disk" "attached-disk" {
  disk = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-from-tf.id
}
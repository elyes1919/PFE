provider "google" {
  project = "pfe-elyes"
  region  = "us-central1"
}
resource "google_compute_instance" "jenkins-1" {
  boot_disk {
    auto_delete = true
    device_name = "jenkins-1"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240910"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-medium"
  name         = "jenkins-1"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/pfe-elyes/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "376185082185-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  
 metadata = {
    ssh-keys = "ahmed:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVt5b43LGf7ft+NWIUC28mo3HEi5EYCozPQgSvCVlxAionW2eq3PDA6fvKwFM7r5TgWvGor4GrwxDSL3cj+fTFfoOFzVfF9lGd1p5WUDhLwiKvkSk7bJcgBf1pVd/vrJj/tKtYc+fJJ1wiXrIO5LovZKM6hCJYBrA7qbR3XrNYkOYvJYx8wsy5bMjIENir46lFKHg+JUpm6zCLm9bOn3JPYal70FeZyINHL4OhaTuRZ3QDf1KU2JOvrBffgu8ZOMOuiXnyWdR21ECD9o+d0xeYaB62htJb/jUDUbel9Il4aSu9+eWa68ECY1ASAzfxLnGKgFLVbVbMg1f51cGSRXXVnCptyq6+BpCtzJeP2GEBlBndTr5gMgck4YGibivvvspBa3DMpLA/tx+J33Fd79bEv0P0mH3AkX61zdEceZkkJsPph0dWjoSek7to6Xy0jQSaDe7PCnT86papUrrS141rzJLfbtuQPpFDGq726Mxnwnby31ENLGWTGYfUDC9nHV0= ahmed@MSI"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = "us-central1-f"
}

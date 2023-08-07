# Set the GCP provider and credentials
# Replace <path_to_your_service_account_key> with the actual path to your service account JSON key file, and <your_project_id> with your GCP project ID.
# Choose the GCP region that is closest to your location to minimize network latency and improve performance. In our case, the closest GCP region to Egypt is the "europe-west2" region. 

provider "google" {
#   credentials = file("<path_to_your_service_account_key>")
  project     = "extended-altar-394912"
  region      = "europe-west2-a"
}



# Define the virtual machine resource
# The machine_type argument specifies the machine type of the VM. In this example, we're using "n1-standard-1", which is a standard machine type with 1 virtual CPU and 3.75 GB of memory.
# Replace "your-ssh-public-key" with your actual SSH public key.
resource "google_compute_instance" "my_vm" {
  name         = "my-vm-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-west2-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2210-kinetic-amd64-v20230126"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "your-ssh-public-key"
  }
}

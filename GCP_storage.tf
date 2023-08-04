// The provider block configures the named provider, in this case "google"
provider "google" {
  // Path to the service account key file
  credentials = file("<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY>")
  // ID of the project that will be used for managing resources
  project     = "<YOUR_PROJECT_ID>"
  // Default region for managing resources
  region      = "europe-west2" // Updated to a region in France
}

// Declare a variable named "bucket_name"
variable "bucket_name" {
  // Description of the variable
  description = "The name of the bucket"
  // Type of the variable
  type        = string
  // Default value of the variable
  default     = "multi-cloud-team" // Updated bucket name
}

// Declare a variable named "location"
variable "location" {
  // Description of the variable
  description = "The location of the bucket"
  // Type of the variable
  type        = string
  // Default value of the variable
  default     = "EU" // Updated to a location in Europe
}

// Declare a variable named "storage_class"
variable "storage_class" {
  // Description of the variable
  description = "The storage class of the bucket"
  // Type of the variable
  type        = string
  // Default value of the variable
  default     = "STANDARD"
}

// Declare a resource of type "google_storage_bucket"
resource "google_storage_bucket" "bucket" {
  // Name of the bucket
  name     = var.bucket_name
  // Location of the bucket
  location = var.location
  // Storage class of the bucket
  storage_class = var.storage_class
}

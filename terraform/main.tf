
provider "google" {
  credentials = "${file("service_account.json")}"
  project     = "vof-testbed-2"
  region      = "${var.region}"
}
terraform {
  backend "gcs" {
    bucket = "db-vof"
    path ="/database-state/terraform.tfstate"
    project = "vof-testbed-2"
    credentials = "service_account.json"
  }
}

data "terraform_remote_state" "vof" {
  backend = "gcs"
  config {
    bucket = "db-vof"
    path = "${var.state_path}"
    project = "vof-testbed-2"
    credentials = "${file("service_account.json")}"
  }
}


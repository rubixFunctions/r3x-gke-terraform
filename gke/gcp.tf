#####################################################################
# Google Cloud Platform
#####################################################################
provider "google" {
  credentials = "${file("${var.credentials}")}"
  project = "${var.project}"
  region  = "${var.region}"
}
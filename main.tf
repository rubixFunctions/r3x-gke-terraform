#####################################################################
# Variables
#####################################################################
variable "project" {
  type = "string"
  description = "Project name."
}
variable "region" {
  type = "string"
  description = "Region name."
}
variable "credentials" {
  type = "string"
  description = "Location of GCP credentials."
}
variable "gcp_cluster_count" {
  type = "string"
  description = "Count of cluster instances to start."
  default = 1
}
variable "cluster_name" {
  type = "string"
  description = "Cluster name for the GCP Cluster."
}
variable "cluster_zone" {
  type = "string"
  description = "Cluster zone for the GCP Cluster."
}
variable "node_pool_name" {
  type = "string"
  description = "Node pool name for the GCP Cluster."
}
variable "node_pool_zone" {
  type = "string"
  description = "Node pool zone for the GCP Cluster."
}

#####################################################################
# Outputs
#####################################################################
output "gcp_cluster_endpoint" {
  value = "${module.gke.host}"
}
output "gcp_cluster_name" {
  value = "${module.gke.gcp_cluster_name}"
}

#####################################################################
# Modules
#####################################################################
module "gke" {
  source            = "./gke"
  project           = "${var.project}"
  region            = "${var.region}"
  credentials       = "${var.credentials}"
  gcp_cluster_count = "${var.gcp_cluster_count}"
  cluster_name      = "${var.cluster_name}"
  cluster_zone      = "${var.cluster_zone}"
  node_pool_name    = "${var.node_pool_name}"
  node_pool_zone    = "${var.node_pool_zone}"
}
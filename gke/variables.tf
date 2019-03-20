#####################################################################
# General Variables
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

#####################################################################
# GCP Variables
#####################################################################
variable "gcp_cluster_count" {
  type = "string"
  description = "Count of cluster instances to start."
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
# GCP Outputs
#####################################################################
output "gcp_cluster_name" {
  value = "${google_container_cluster.rubix.name}"
}
output "host" {
  value = "${google_container_cluster.rubix.endpoint}"
}
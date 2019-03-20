#####################################################################
# GKE Cluster
#####################################################################
resource "google_container_cluster" "rubix" {
  name = "${var.cluster_name}"
  zone = "${var.cluster_zone}"
  initial_node_count = "${var.gcp_cluster_count}"

  node_config {
    oauth_scopes = [
      "service-control",
      "service-management",
      "compute-rw",
      "storage-ro",
      "cloud-platform",
      "logging-write",
      "monitoring-write",
      "pubsub",
      "datastore"
    ]
    labels {
      this-is-for = "dev-cluster"
    }
    tags = ["dev"]
    machine_type = "n1-standard-4"
  }
}
resource "google_container_node_pool" "rubix" {
  name       = "${var.node_pool_name}"
  zone       = "${var.node_pool_zone}"
  cluster    = "${google_container_cluster.rubix.name}"
  autoscaling {
    min_node_count = 1
    max_node_count = 10
  }
  management {
    auto_repair = true
  }
}
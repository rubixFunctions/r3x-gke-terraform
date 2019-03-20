#####################################################################
# Knative
#####################################################################
resource "null_resource" "init" {
  depends_on = [
    "google_container_cluster.rubix",
    "google_container_node_pool.rubix"
  ]
  triggers {
    cluster_instance_ids = "${join(",", google_container_cluster.rubix.*.id)}"
  }
  #####################################################################
  # Configure Kubernetes
  #####################################################################
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials rubix-cluster --zone=${google_container_cluster.my-project.zone}"
  }
  #####################################################################
  # Role Permissions
  #####################################################################
  provisioner "local-exec" {
    command = "kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)"
  }
  #####################################################################
  # Install Istio
  #####################################################################
  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/istio-crds.yaml"
  }
  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/istio.yaml"
  }
  provisioner "local-exec" {
    command = "kubectl label namespace default istio-injection=enabled"
  }
  #####################################################################
  # Install Knative Components
  #####################################################################
  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/serving.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/build/releases/download/v0.4.0/build.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/eventing/releases/download/v0.4.0/in-memory-channel.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/eventing/releases/download/v0.4.0/release.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/eventing-sources/releases/download/v0.4.0/release.yaml "
  }

  provisioner "local-exec" {
    command = "kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/monitoring.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl apply --filename https://raw.githubusercontent.com/knative/serving/v0.4.0/third_party/config/build/clusterrole.yaml"
  }
  
}
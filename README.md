# RubiX GKE Terraform

[![License](https://img.shields.io/badge/-Apache%202.0-blue.svg)](https://opensource.org/s/Apache-2.0)

## Usage
It is assumed you have [Terraform](), [gcloud]() and [kubectl]() installed locally. Also ensure you have billing enabled in GKE.

1. Clone this repo:
```
$ git clone git@github.com:rubixFunctions/r3x-gke-terraform.git
$ cd r3x-gke-terraform
```

2. Edit env vars in `.gtf-var` to suit your cluster. Once done run:
```
$ source .gtf-var
```

3. Run the following to execute the terraform:
```
$ terraform init
$ terraform plan
$ terraform apply
```

4. To ensure all knative services have been applied run the following:
```
$ kubectl get pods --namespace istio-system
$ kubectl get pods --namespace knative-serving
$ kubectl get pods --namespace knative-build
$ kubectl get pods --namespace knative-eventing
$ kubectl get pods --namespace knative-sources
$ kubectl get pods --namespace knative-monitoring
```

5. To allow outbound traffic run the following:
```
$ gcloud container clusters describe ${CLUSTER_NAME} \
  --zone=${CLUSTER_ZONE} | grep -e clusterIpv4Cidr -e servicesIpv4Cidr
```
The `istio.sidecar.includeOutboundIPRanges` parameter in the `config-network` map specifies the IP ranges that Istio sidecar intercepts. To allow outbound access, replace the default parameter value with the IP ranges of your cluster.

Run the following command to edit the `config-network` map:
```
$ kubectl edit configmap config-network --namespace knative-serving
```
Change the `istio.sidecar.includeOutboundIPRanges` parameter value from * to the IP range you need. Separate multiple IP entries with a comma. For example:
```
apiVersion: v1
data:
  istio.sidecar.includeOutboundIPRanges: '10.16.0.0/14,10.19.240.0/20'
kind: ConfigMap
metadata:
  ...
```

## Documentation
For full information on RubiX and deploying a function to Knative, refer to our [Documentation here.](https://github.com/rubixFunctions/r3x-docs/blob/master/README.md)

## License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details
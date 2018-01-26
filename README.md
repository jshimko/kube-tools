# kube-helm

A lightweight Docker image (based on Alpine) that comes with all the tools you need to work with Kubernetes and Helm charts. Great for simplifying your CI workflows!

## Included Tools

Kubernetes tools:
 - kubectl 1.9.2 - <https://kubernetes.io/docs/reference/kubectl/overview/>
 - helm 2.8.0 - <https://github.com/kubernetes/helm>
 - helm-s3 plugin 0.5.1 - <https://github.com/hypnoglow/helm-s3>

CI tools:
 - yamllint - <https://github.com/adrienverge/yamllint>
 - yq (YAML parser based on `jq`) - <https://github.com/kislyuk/yq>

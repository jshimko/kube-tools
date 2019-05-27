# kube-helm

A lightweight Docker image (based on Alpine) that comes with all the tools you need to work with Kubernetes and Helm charts. Great for simplifying your CI workflows!

## Included Tools

Kubernetes tools:
 - kubectl 1.14.2 - <https://kubernetes.io/docs/reference/kubectl/overview/>
 - helm 2.14.0 - <https://github.com/kubernetes/helm>
 - helm-s3 plugin 0.8.0 - <https://github.com/hypnoglow/helm-s3>

Misc CI/CD tools:
 - awscli <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html>
 - aws-iam-authenticator <https://github.com/kubernetes-sigs/aws-iam-authenticator>
 - yamllint - <https://github.com/adrienverge/yamllint>
 - yq (YAML parser based on `jq`) - <https://github.com/kislyuk/yq>


## Example Usage

```sh
# administer an AWS EKS cluster
# (note that all of the following environment variables are required)
docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \ # required
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \ # required
  -e AWS_DEFAULT_REGION="us-west-2" \ # default value if omitted
  -e EKS_CLUSTER_NAME="my-cluster" \ # required
  jshimko/kube-helm:latest

# the above command drops into a bash shell with
# all of the tooling for the following commands...

# configure kubectl auth for an existing EKS cluster
aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

# confirm it worked by listing your pods
kubectl get pods --all-namespaces

# or list your helm deployments
helm ls

# now do stuff on CI, etc.
```

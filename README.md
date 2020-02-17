# kube-tools-aws

A lightweight Docker image (based on Alpine) that comes with all the tools you need to work with Kubernetes, Helm charts, AWS (awscli), and AWS EKS. Intended to be a flexible foundation of tools for CI/CD workflows.

## Included Tools

 - kubectl 1.17.3 - https://kubernetes.io/docs/reference/kubectl/overview/
 - helm 3 - https://github.com/kubernetes/helm
 - awscli https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html
 - aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator
 - yamllint - https://github.com/adrienverge/yamllint
 - yq (YAML parser based on `jq`) - https://github.com/kislyuk/yq


## Example Usage

```sh
# start up an image to administer an AWS EKS cluster
docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \
  -e AWS_DEFAULT_REGION="us-west-2" \
  coastapp/kube-tools-aws:latest

# the above command drops into a bash shell with
# all of the tooling for the following commands...

# configure kubectl auth for an existing EKS cluster named "my-cluster"
aws eks update-kubeconfig --name my-cluster

# confirm it worked by listing your pods
kubectl get pods --all-namespaces

# or list your helm deployments
helm ls --all-namespaces

# now do stuff for your CI/CD process...
```

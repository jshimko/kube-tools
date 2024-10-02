# kube-tools

A Docker image based on Debian 12 that comes with all the tools you need to work with Kubernetes, Helm charts, AWS (awscli), AWS EKS, and Digital Ocean Kubernetes. Intended to be a flexible foundation of tools for CI/CD workflows.

## Included Tools

- kubectl - <https://kubernetes.io/docs/reference/kubectl/overview/>
- Helm 3 - <https://github.com/kubernetes/helm>
- Helm S3 plugin - <https://github.com/hypnoglow/helm-s3>
- Docker - <https://docs.docker.com/engine/install/debian/#install-using-the-repository>
- awscli - <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html>
- doctl - <https://docs.digitalocean.com/reference/doctl/>
- psql - <https://www.postgresql.org/docs/17/app-psql.html>
- yamllint - <https://github.com/adrienverge/yamllint>
- yq (YAML parser based on `jq`) - <https://github.com/kislyuk/yq>

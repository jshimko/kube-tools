#!/bin/sh

set -e

apk add --update py3-pip curl make openssl groff wget

# install kubectl
curl -L "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl
kubectl version --client

# install Helm
# https://helm.sh/docs/intro/install/#from-script
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh

# install S3 plugin for Helm
helm plugin install https://github.com/hypnoglow/helm-s3.git --version $HELM_S3_PLUGIN_VERSION

# aws-iam-authenticator
# https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator.sha256
openssl sha1 -sha256 aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
aws-iam-authenticator help

# Digital Ocean CLI (doctl)
wget https://github.com/digitalocean/doctl/releases/download/v1.64.0/doctl-1.64.0-linux-amd64.tar.gz
tar xf ./doctl-1.64.0-linux-amd64.tar.gz
mv ./doctl /usr/local/bin
rm ./doctl-1.64.0-linux-amd64.tar.gz
doctl help

# install YAML tools
pip install yamllint yq

# cleanup
rm /var/cache/apk/*
rm -rf /tmp/*

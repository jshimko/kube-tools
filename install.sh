#!/bin/sh

set -e

apk add --update -t deps curl make py-pip openssl

# install kubectl
# https://aur.archlinux.org/packages/kubectl-bin/
KUBECTL_VERSION=1.17.3
curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

# install Helm
# https://helm.sh/docs/intro/install/#from-script
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh

# aws-iam-authenticator
# https://github.com/kubernetes-sigs/aws-iam-authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
aws-iam-authenticator help

# awscli
pip install awscli
aws --version

# install YAML tools
pip install yamllint yq

# cleanup
apk del --purge deps
rm /var/cache/apk/*
rm -rf /tmp/*

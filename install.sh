#!/bin/sh

HELM_FILENAME="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

apk add --update ca-certificates git python
apk add --update -t deps curl make py-pip
apk add bash

curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl
curl -L http://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} -o /tmp/${HELM_FILENAME}
tar -zxvf /tmp/${HELM_FILENAME} -C /tmp
mv /tmp/linux-amd64/helm /usr/local/bin/helm

# Setup Helm so that it will work with helm dep commands
helm init -c

# install S3 plugin for Helm
helm plugin install https://github.com/hypnoglow/helm-s3.git --version $HELM_S3_PLUGIN_VERSION

# install YAML linter
pip install yamllint yq

# cleanup
apk del --purge deps
rm /var/cache/apk/*
rm -rf /tmp/*

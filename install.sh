#!/bin/sh

apk add --update bash ca-certificates git python
apk add --update -t deps curl make py-pip

# install kubectl
curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

# install Helm
HELM_FILENAME="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
curl -L http://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} -o /tmp/${HELM_FILENAME}
tar -zxvf /tmp/${HELM_FILENAME} -C /tmp
mv /tmp/linux-amd64/helm /usr/local/bin/helm

# initialize Helm client
helm init -c

# install S3 plugin for Helm
helm plugin install https://github.com/hypnoglow/helm-s3.git --version $HELM_S3_PLUGIN_VERSION

# install YAML tools
pip install yamllint yq

# cleanup
apk del --purge deps
rm /var/cache/apk/*
rm -rf /tmp/*

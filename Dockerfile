FROM alpine:3.11

# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBECTL_VERSION "1.17.4"

# https://github.com/hypnoglow/helm-s3
ENV HELM_S3_PLUGIN_VERSION "0.9.2"

# set some defaults
ENV AWS_DEFAULT_REGION "us-west-2"

RUN apk --no-cache upgrade
RUN apk add --update bash ca-certificates git python

COPY install.sh /opt/install.sh
RUN /opt/install.sh

CMD bash

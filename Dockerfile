FROM alpine:3.10

# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBECTL_VERSION "1.15.5"

# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION "3.0.0"

# https://github.com/hypnoglow/helm-s3
ENV HELM_S3_PLUGIN_VERSION "0.8.0"

# set some defaults
ENV AWS_DEFAULT_REGION "us-west-2"

COPY install.sh /opt/install.sh
RUN /opt/install.sh

CMD bash

FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt upgrade -y && \
  apt install -y --no-install-recommends \
    curl ca-certificates git gnupg2 python3 pipx vim wget && \
  install -d /usr/share/postgresql-common/pgdg && \
  curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
  echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list && \
  apt update && apt install -y --no-install-recommends postgresql-client-16 && \
  rm -rf /var/lib/apt/lists/*

RUN pipx install awscli
RUN pipx install yamllint

# kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
  mv kubectl /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  kubectl version --client

# helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# helm S3 plugin
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git

# aws-iam-authenticator
# https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
RUN curl https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64 -Lo aws-iam-authenticator && \
  chmod +x ./aws-iam-authenticator && \
  mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator && \
  aws-iam-authenticator help

# Digital Ocean CLI (doctl)
RUN DOCTL_VERSION=1.100.0 && \
  wget https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
  tar xf ./doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
  mv ./doctl /usr/local/bin && \
  rm ./doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
  doctl help

CMD bash

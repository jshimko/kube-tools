FROM debian:12.7-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt upgrade -y && \
  apt install -y --no-install-recommends \
    curl ca-certificates git gnupg2 python3 pipx rclone vim wget && \
  # Docker
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
  chmod a+r /etc/apt/keyrings/docker.gpg && \
  echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && \
  apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
  # https://www.postgresql.org/download/linux/debian/
  install -d /usr/share/postgresql-common/pgdg && \
  curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
  echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list && \
  apt update && apt install -y --no-install-recommends postgresql-client-17 && \
  rm -rf /var/lib/apt/lists/*

# misc tools
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

# Digital Ocean CLI (doctl)
RUN DOCTL_VERSION=1.115.0 && \
  wget https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
  tar xf ./doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
  mv ./doctl /usr/local/bin && \
  rm ./doctl-${DOCTL_VERSION}-linux-amd64.tar.gz && \
  doctl help

CMD bash

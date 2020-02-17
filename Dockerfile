FROM alpine:3.11

# set some defaults
ENV AWS_DEFAULT_REGION "us-west-2"

RUN apk --no-cache upgrade
RUN apk add --update bash ca-certificates git python

COPY install.sh /opt/install.sh
RUN /opt/install.sh

CMD bash

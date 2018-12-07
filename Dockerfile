ARG IMAGE_TAG

FROM ibmcom/ibm-cloud-developer-tools-amd64:${IMAGE_TAG}

LABEL organization="Ourchitecture"
LABEL license="MIT"
LABEL url="https://github.com/ourchitecture/docker-ibmcloud-cli"

USER root

RUN apk update \
    && ibmcloud config --check-version=false && \
    apk add --no-cache bash docker

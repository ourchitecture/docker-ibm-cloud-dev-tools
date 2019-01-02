ARG IMAGE_TAG="0.12.1"

FROM ibmcom/ibm-cloud-developer-tools-amd64:${IMAGE_TAG}

LABEL organization="Ourchitecture"
LABEL license="MIT"
LABEL url="https://github.com/ourchitecture/docker-ibmcloud-cli"

USER root

RUN apk update \
    && ibmcloud config --check-version=false \
    && apk add --no-cache curl bash docker \
    && ibmcloud --version

CMD ["ibmcloud"]

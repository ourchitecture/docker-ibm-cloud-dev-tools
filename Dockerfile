ARG IMAGE_TAG="0.12.1"

FROM ibmcom/ibm-cloud-developer-tools-amd64:${IMAGE_TAG}

LABEL organization="Ourchitecture"
LABEL license="MIT"
LABEL url="https://github.com/ourchitecture/docker-ibmcloud-cli"

USER root

RUN apk update \
    && apk add --no-cache curl bash docker \

    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apk add --no-cache nodejs \
    && npm install -g npm@latest \

    && ibmcloud config --check-version=false \
    && ibmcloud --version \
    && ibmcloud cf --version \
    && docker --version \
    && kubectl --version \
    && node --version \
    && npm --version

CMD ["ibmcloud"]

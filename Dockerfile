ARG IMAGE_TAG="0.16.0"
ARG PUPPETEER_VERSION="1.16.0"

FROM ibmcom/ibm-cloud-developer-tools-amd64:${IMAGE_TAG}

LABEL organization="Ourchitecture"
LABEL license="MIT"
LABEL url="https://github.com/ourchitecture/docker-ibm-cloud-dev-tools"

USER root

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/

COPY package.json /package.json

# It's a good idea to use dumb-init to help prevent zombie chrome processes.
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init

RUN apk update \
    && apk upgrade \
    && apk add --no-cache gnupg curl bash docker make gcc g++ python git nodejs nodejs-npm \
    && npm install -g npm@latest \
    # replacing default repositories with edge ones
    && echo @edge http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    # https://github.com/GoogleChrome/puppeteer/issues/3703#issuecomment-450226060
    && apk add --no-cache chromium@edge freetype@edge harfbuzz@edge nss@edge \
    && chmod +x /usr/local/bin/dumb-init \
    && npm install puppeteer@$PUPPETEER_VERSION --global \
    && ibmcloud config --check-version=false \
    && echo 'IBM Cloud version:' \
    && ibmcloud --version \
    && echo 'IBM Cloud CF version:' \
    && ibmcloud cf --version \
    && echo 'Docker version:' \
    && docker --version \
    && echo 'Kubernetes version:' \
    && kubectl version --client \
    && echo 'Node version:' \
    && node --version \
    && echo 'NPM version:' \
    && npm --version \
    && echo 'Chrome version:' \
    && chromium-browser --version

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["ibmcloud"]

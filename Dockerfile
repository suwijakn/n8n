FROM n8nio/n8n:latest

USER root

RUN mkdir -p /secrets && chown -R node:node /secrets

RUN mkdir -p /custom-modules && chown -R node:node /custom-modules

USER node

WORKDIR /custom-modules

RUN npm install \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

WORKDIR /home/node
ENV NODE_PATH=/custom-modules/node_modules \
    NODE_FUNCTION_ALLOW_E
    XTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

USER node
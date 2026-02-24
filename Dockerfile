FROM n8nio/n8n:latest

USER root

RUN mkdir -p /data/custom_modules
WORKDIR /data/custom_modules

RUN npm init -y
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

ENV NODE_PATH=/data/custom_modules/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    N8N_RUNNERS_ENABLED=false \
    TZ=Asia/Bangkok

USER node
FROM n8nio/n8n:latest

USER root

# Create directory for custom modules
RUN mkdir -p /data/custom_modules

WORKDIR /data/custom_modules

# Initialize package.json
RUN npm init -y

# Install modules locally (NOT global)
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# Tell n8n where to find them
ENV NODE_PATH=/data/custom_modules/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

USER node
FROM n8nio/n8n:latest

USER root

# Create secrets dir
RUN mkdir -p /secrets && chown -R node:node /secrets

# Move to n8n installation directory
WORKDIR /usr/local/lib/node_modules/n8n

# Install external modules locally (NOT global)
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# Allow n8n to use external modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

USER node
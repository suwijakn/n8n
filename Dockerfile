# Dockerfile
FROM n8nio/n8n:latest

# Create secrets dir
USER root
RUN mkdir -p /secrets && chown -R node:node /secrets

# Install external libs globally
RUN npm install -g pdf-lib @google-cloud/documentai fast-levenshtein

# Run as n8n user
USER node

# Make Node see global modules; set envs for n8n
ENV NODE_PATH=/usr/local/lib/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein" \
    GOOGLE_APPLICATION_CREDENTIALS="/secrets/gcp-sa.json" \
    TZ="Asia/Bangkok"

# Dockerfile
FROM n8nio/n8n:latest

# Switch to root to install global packages
USER root

# Create secrets dir
RUN mkdir -p /secrets && chown -R node:node /secrets

# Install required external modules globally
RUN npm install -g \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# Grant access to global node_modules from within n8n's vm2 sandbox
ENV NODE_PATH=/usr/local/lib/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

# Drop back to node user for security
USER node

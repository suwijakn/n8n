FROM n8nio/n8n:latest

USER root

# Clean install to the standard global directory n8n expects
RUN npm install -g pdf-lib @google-cloud/documentai fast-levenshtein

# Explicitly set permissions for the node user on the global modules
RUN chown -R node:node /usr/local/lib/node_modules

# Standard n8n environment variables - NO BLANK LINES in the ENV block
ENV NODE_PATH=/usr/local/lib/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    NODE_FUNCTION_ALLOW_BUILTIN=* \
    GOOGLE_APPLICATION_CREDENTIALS=/etc/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

USER node
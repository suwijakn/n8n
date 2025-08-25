# Dockerfile
FROM n8nio/n8n:latest

# Switch to root to install global modules and setup
USER root

# Create secrets directory for service account
RUN mkdir -p /secrets && chown -R node:node /secrets

# Install external libraries globally
RUN npm install -g \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# Set environment variables needed by Code node (vm2)
ENV NODE_PATH=/usr/local/lib/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

# Copy startup script and set permissions
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Switch back to node user for safety
USER node

# Start n8n using the custom script
CMD [ "start.sh" ]

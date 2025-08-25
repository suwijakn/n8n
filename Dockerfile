# Dockerfile
FROM n8nio/n8n:latest

# Switch to root to install global modules and setup
USER root

# Create secrets directory
RUN mkdir -p /secrets && chown -R node:node /secrets

# Install external libraries globally
RUN npm install -g \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# Set required environment variables for vm2
ENV NODE_PATH=/usr/local/lib/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json \
    TZ=Asia/Bangkok

# Copy custom start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Switch back to node user
USER node

# Use custom start script
ENTRYPOINT ["/start.sh"]

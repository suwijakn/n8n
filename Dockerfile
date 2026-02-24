FROM n8nio/n8n:latest

# Switch to root to install packages globally
USER root

# Install the necessary packages
RUN npm install -g pdf-lib @google-cloud/documentai fast-levenshtein

# Set NODE_PATH so the n8n task runner can locate the globally installed modules
ENV NODE_PATH=/usr/local/lib/node_modules

# Switch back to the node user for security
USER node
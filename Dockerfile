FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Change working directory to where NODE_PATH expects the modules
WORKDIR /usr/local/lib

# Install packages locally (without -g) so they are placed directly in /usr/local/lib/node_modules without symlinks
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# Set NODE_PATH so the n8n task runner can locate the modules
ENV NODE_PATH=/usr/local/lib/node_modules

# Switch back to the n8n default directory and user for security
WORKDIR /home/node
USER node
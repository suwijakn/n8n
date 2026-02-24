FROM n8nio/n8n:latest

# Switch to root to create a dedicated directory for custom modules and set permissions
USER root
RUN mkdir /custom-modules && chown node:node /custom-modules

# Switch back to the unprivileged 'node' user
USER node

# Change to the new directory
WORKDIR /custom-modules

# Install packages locally. This creates /custom-modules/node_modules safely
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# Set NODE_PATH so the n8n task runner can locate these modules
ENV NODE_PATH=/custom-modules/node_modules

# Switch back to the n8n default directory
WORKDIR /home/node
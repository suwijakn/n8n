FROM n8nio/n8n:latest

USER root

# Change to a directory higher up in the path that doesn't conflict with n8n's core files.
# Running npm install here safely generates /usr/local/node_modules.
WORKDIR /usr/local

# Install the packages. 
# Because the Task Runner runs from /usr/local/lib/node_modules/n8n/...
# it will natively climb the tree and find these in /usr/local/node_modules automatically!
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# Switch back to the secure default n8n user and directory
WORKDIR /home/node
USER node
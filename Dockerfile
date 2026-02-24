FROM n8nio/n8n:latest

USER root

# Clean install to the standard global directory n8n expects
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

USER node

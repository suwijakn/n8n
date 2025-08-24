# Dockerfile
FROM n8nio/n8n:latest

USER root
# Make sure global npm installs go under /usr/local
ENV NPM_CONFIG_PREFIX=/usr/local

# Install external libs globally (NO spaces or extra characters)
RUN npm install -g @google-cloud/documentai pdf-lib fast-levenshtein \
 && ls -la /usr/local/lib/node_modules

# Drop privileges
USER node

# Make Node see global modules (for Code node)
ENV NODE_PATH=/usr/local/lib/node_modules \
    TZ="Asia/Bangkok"

# Dockerfile
FROM n8nio/n8n:latest

# Install external libs globally
USER root
RUN npm install -g pdf-lib @google-cloud/documentai fast-levenshtein

# Run as n8n user
USER node

# Make Node see global modules (for Code node)
ENV NODE_PATH=/usr/local/lib/node_modules \
    TZ="Asia/Bangkok"

# n8n image already exposes 5678 and has the default CMD
# Render will provide $PORT at runtime; we’ll pass it via env

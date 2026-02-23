FROM n8nio/n8n:latest

USER root

# 1. Create secrets dir and ensure permissions
RUN mkdir -p /secrets && chown -R node:node /secrets

# 2. Switch to node user so we install in the user's home path
USER node
WORKDIR /home/node

# 3. Install locally in /home/node. 
# This avoids global permission issues and the Task Runner can find it easily.
RUN npm install \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# 4. Define Environment Variables
# We set NODE_PATH to exactly where we just installed the modules
ENV NODE_PATH=/home/node/node_modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein"
ENV GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json
ENV TZ=Asia/Bangkok

# Ensure we stay as the node user
USER node
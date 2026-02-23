FROM n8nio/n8n:latest

USER root

# 1. Create secrets dir
RUN mkdir -p /secrets && chown -R node:node /secrets

# 2. Go into the actual n8n installation directory
WORKDIR /usr/local/lib/node_modules/n8n

# 3. Force install the modules here so they are part of the n8n "tree"
# We use --save-dev or just install to ensure they land in n8n/node_modules
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# 4. Set Environment Variables
# We point NODE_PATH to n8n's own node_modules as a fallback
ENV NODE_PATH=/usr/local/lib/node_modules/n8n/node_modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein"
ENV GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json
ENV TZ=Asia/Bangkok

# 5. Switch back to default n8n home and node user
WORKDIR /home/node
USER node
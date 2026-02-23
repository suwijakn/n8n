FROM n8nio/n8n:latest

USER root

# 1. Setup secrets
RUN mkdir -p /secrets && chown -R node:node /secrets

# 2. Go to the ACTUAL n8n installation directory
# This is where the Task Runner looks for modules
WORKDIR /usr/local/lib/node_modules/n8n

# 3. Install modules here. 
# We use --save to ensure they are added to the n8n package tree
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# 4. Set Environment Variables
ENV NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein"
ENV GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json
ENV TZ=Asia/Bangkok
# Adding this as a backup to the Render UI setting
ENV N8N_BLOCK_JS_PYTHON_TASK_RUNNERS=true

# 5. Return to default home
WORKDIR /home/node
USER node
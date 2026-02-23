FROM n8nio/n8n:latest

USER root

# 1. Create secrets dir
RUN mkdir -p /secrets && chown -R node:node /secrets

# 2. Install packages globally. 
# We add --allow-root and use a specific path to ensure it succeeds.
RUN npm install -g --production \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# 3. Force the n8n directory to recognize these global modules
# We link them from the global storage into the n8n-specific node_modules
RUN ln -s /usr/local/lib/node_modules/pdf-lib /usr/local/lib/node_modules/n8n/node_modules/pdf-lib && \
    ln -s /usr/local/lib/node_modules/@google-cloud /usr/local/lib/node_modules/n8n/node_modules/@google-cloud && \
    ln -s /usr/local/lib/node_modules/fast-levenshtein /usr/local/lib/node_modules/n8n/node_modules/fast-levenshtein

# 4. Set Environment Variables
# Crucial: Task Runner needs to know where to look
ENV NODE_PATH=/usr/local/lib/node_modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein"
ENV GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json
ENV N8N_BLOCK_JS_PYTHON_TASK_RUNNERS=true

USER node
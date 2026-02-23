FROM n8nio/n8n:latest

USER root

# 1. Create secrets directory
RUN mkdir -p /secrets && chown -R node:node /secrets

# 2. Install packages directly into a persistent system-wide location.
# We use --unsafe-perm to prevent permission errors during npm post-install scripts.
RUN npm install -g --unsafe-perm \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# 3. Set environment variables individually to avoid the parsing error you saw.
# We point NODE_PATH to the global modules so the Task Runner can find them.
ENV NODE_PATH=/usr/local/lib/node_modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein"
ENV GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json
ENV TZ=Asia/Bangkok

# 4. Switch back to the node user for security
USER node
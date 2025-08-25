# Dockerfile — n8n on Render with Code-node externals

FROM n8nio/n8n:latest

USER root
ENV NPM_CONFIG_PREFIX=/usr/local

# 1) Install globally (optional but nice for debugging)
RUN npm install -g @google-cloud/documentai pdf-lib fast-levenshtein \
 && ls -la /usr/local/lib/node_modules

# 2) ALSO install INSIDE the n8n package dir so vm2 resolves them for the Code node
#    --no-save avoids touching n8n’s package.json (pnpm-managed)
RUN npm install --no-save --omit=dev --no-audit --no-fund \
    --prefix /usr/local/lib/node_modules/n8n \
    @google-cloud/documentai pdf-lib fast-levenshtein \
 && ls -la /usr/local/lib/node_modules/n8n/node_modules/@google-cloud || true \
 && ls -la /usr/local/lib/node_modules/n8n/node_modules/pdf-lib || true

# Drop privileges
USER node

# Optional: still expose globals; set timezone
ENV NODE_PATH=/usr/local/lib/node_modules \
    TZ="Asia/Bangkok"

# Dockerfile — n8n on Render with external libs for Code node

FROM n8nio/n8n:latest

USER root

# Ensure global prefix is /usr/local
ENV NPM_CONFIG_PREFIX=/usr/local

# 1) Install externals globally (good for CLI/tests)
# 2) ALSO place them where the Code node certainly resolves: /usr/local/lib/node_modules/n8n/node_modules
RUN set -eux; \
  npm install -g @google-cloud/documentai pdf-lib fast-levenshtein; \
  ls -la /usr/local/lib/node_modules; \
  # create a local node_modules under the n8n package dir
  mkdir -p /usr/local/lib/node_modules/n8n/node_modules; \
  # link scoped and unscoped packages into the n8n package's node_modules
  ln -s /usr/local/lib/node_modules/@google-cloud /usr/local/lib/node_modules/n8n/node_modules/@google-cloud || true; \
  ln -s /usr/local/lib/node_modules/pdf-lib /usr/local/lib/node_modules/n8n/node_modules/pdf-lib || true; \
  ln -s /usr/local/lib/node_modules/fast-levenshtein /usr/local/lib/node_modules/n8n/node_modules/fast-levenshtein || true; \
  # show what we have where vm2 will look first
  ls -la /usr/local/lib/node_modules/n8n/node_modules

# Drop privileges
USER node

# Make Node see global modules too; set timezone
ENV NODE_PATH=/usr/local/lib/node_modules \
    TZ="Asia/Bangkok"

# n8n exposes 5678 and has CMD; Render will pass $PORT which we map to N8N_PORT via env.

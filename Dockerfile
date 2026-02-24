FROM n8nio/n8n:latest

USER root

# Create secrets dir (Render standard is usually /etc/secrets, but keeping this if you use it locally)
RUN mkdir -p /secrets && chown -R node:node /secrets

# Create a dedicated directory for custom modules to avoid global path conflicts
RUN mkdir -p /custom-modules && chown -R node:node /custom-modules

# Switch to node user to install packages safely
USER node

# Install required external modules locally in the custom directory
WORKDIR /custom-modules
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# Switch WORKDIR back to the default n8n directory
WORKDIR /home/node

# Set environment variables in Docker
# (No blank lines between trailing slashes!)
ENV NODE_PATH=/custom-modules/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    NODE_FUNCTION_ALLOW_BUILTIN=* \
    GOOGLE_APPLICATION_CREDENTIALS=/etc/secrets/gcp-sa.json \
    TZ=Asia/Bangkok
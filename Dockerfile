FROM n8nio/n8n:latest

# Switch to root to create directories and set permissions
USER root

# Create secrets dir
RUN mkdir -p /secrets && chown -R node:node /secrets

# 1. Create a dedicated directory for your custom modules and grant ownership
RUN mkdir -p /custom-modules && chown -R node:node /custom-modules

# 2. Switch to the 'node' user BEFORE installing
USER node

# 3. Set the working directory to our new folder
WORKDIR /custom-modules

# 4. Install the modules locally
RUN npm install \
    pdf-lib \
    @google-cloud/documentai \
    fast-levenshtein

# 5. Switch the working directory back to n8n's default
WORKDIR /home/node

# 6. Set environment variables on separate lines to avoid parsing syntax errors
ENV NODE_PATH=/custom-modules/node_modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL="pdf-lib,@google-cloud/documentai,fast-levenshtein"
ENV GOOGLE_APPLICATION_CREDENTIALS=/secrets/gcp-sa.json
ENV TZ=Asia/Bangkok

# Ensure we remain the node user for security
USER node
FROM n8nio/n8n:latest

USER root

# create custom extensions directory
RUN mkdir -p /home/node/.n8n/custom
WORKDIR /home/node/.n8n/custom

# init local package
RUN npm init -y

# install external libs here
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein

# fix permission
RUN chown -R node:node /home/node/.n8n

ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/custom \
    TZ=Asia/Bangkok

USER node
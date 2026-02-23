FROM node:20-alpine AS builder

WORKDIR /app
RUN npm init -y
RUN npm install pdf-lib @google-cloud/documentai fast-levenshtein


FROM n8nio/n8n:latest

USER root

# copy only node_modules from builder
COPY --from=builder /app/node_modules /usr/local/lib/node_modules/n8n/node_modules

ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    TZ=Asia/Bangkok

USER node
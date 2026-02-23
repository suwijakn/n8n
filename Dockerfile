FROM n8nio/n8n:latest

USER root

# เข้าไปที่ n8n app directory
WORKDIR /usr/local/lib/node_modules/n8n

# ใช้ pnpm (เพราะ n8n ใช้ pnpm)
RUN pnpm add pdf-lib @google-cloud/documentai fast-levenshtein

# allow external modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@google-cloud/documentai,fast-levenshtein \
    TZ=Asia/Bangkok

USER node
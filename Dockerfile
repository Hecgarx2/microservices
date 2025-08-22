# Imagen base común
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./

RUN npm config set strict-ssl false \
 && npm config set registry http://registry.npmjs.org/
RUN apk add --no-cache openssl libc6-compat

# Dev
FROM base AS dev

RUN npm install 
COPY . .

CMD ["sh", "-c", "npx prisma generate && npm run start:dev"]

# Build
FROM base AS builder

RUN npm install 
COPY . .

RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

CMD ["sh", "-c", "npx prisma generate && node dist/main.js"]

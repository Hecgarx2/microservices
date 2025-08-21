# Imagen base común
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./

RUN npm config set strict-ssl false \
 && npm config set registry http://registry.npmjs.org/


# Dev
FROM base AS dev

RUN npm install --verbose
COPY . .

CMD ["npm", "run", "start:dev"]

# Build
FROM base AS builder

RUN npm install --verbose
COPY . .

RUN npx prisma generate

RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

CMD ["node", "dist/main.js"]
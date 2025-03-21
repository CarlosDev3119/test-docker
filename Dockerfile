FROM node:22.14.0-bookworm as dev-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

FROM node:22.14.0-bookworm as builder
WORKDIR /app
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:22.14.0-bookworm as prod-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

FROM node:22.14.0-bookworm as prod
EXPOSE 3000
WORKDIR /app
ENV APP_VERSION=${APP_VERSION}
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD [ "node","dist/app.js"]

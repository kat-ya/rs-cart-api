FROM node:12 AS builder
WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build

FROM alpine:latest
WORKDIR /app
COPY --from=builder app/node_modules .
COPY --from=builder app/dist .

# Application
USER node
ENV PORT=4000
EXPOSE 8080

CMD ["node", "dist/main.js"]
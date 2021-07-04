FROM node:12 AS builder
WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build

FROM node:12-alpine
WORKDIR /app
COPY --from=builder app/node_modules .
COPY --from=builder app/dist .

# Application
ENV PORT=4000
EXPOSE 80

CMD ["node", "dist/main.js"]
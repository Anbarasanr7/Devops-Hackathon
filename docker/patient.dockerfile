# patient-service/Dockerfile
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install dependencies (cache package.json)
COPY package*.json ./
RUN npm ci --only=production

# Copy source
COPY . .

# Health/check env & port (default 3000)
ENV PORT=3000
EXPOSE ${PORT}

# Use non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD ["node", "patient-service.js"]

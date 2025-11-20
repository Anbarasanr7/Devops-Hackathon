FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
ENV PORT=3001
EXPOSE ${PORT}
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
CMD ["node", "appointment-service.js"]

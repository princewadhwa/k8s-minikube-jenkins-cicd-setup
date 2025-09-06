# Stage 1: Build Stage
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package files and install dependencies
COPY src/package*.json ./
RUN npm install

# Copy source code
COPY src/ .

# Stage 2: Final Stage
FROM node:18-alpine
WORKDIR /app

# Copy only necessary files from builder (node_modules and app code)
COPY --from=builder /app .

# Expose port
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]

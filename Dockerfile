# Use official Node.js LTS image as base
FROM node:20-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy rest of the application code
COPY . .

# Expose port your app runs on (default 3000)
EXPOSE 3000

# Start the Node.js application
CMD ["node", "app.js"]


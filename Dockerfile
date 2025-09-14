FROM node:20-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production
COPY . .
# Expose port your app runs on (default 3000)
EXPOSE 3000
CMD ["node", "app.js"]


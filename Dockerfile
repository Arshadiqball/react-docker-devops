# Use an official Node.js image as the base image (Node.js 16 in this case)
FROM node:16-alpine as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if you are using npm)
COPY package*.json ./

# Install dependencies using npm
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Use NGINX to serve the built files
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

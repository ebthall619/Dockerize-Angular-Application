# First stage: building the Angular application
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if present)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the source code
COPY . .

# Build the application
RUN npm run build --production

# Second stage: serving the application using Nginx
FROM nginx:alpine

# Copy the built application from the previous stage to the Nginx server directory
COPY --from=build /app/dist/helpdesk /usr/share/nginx/html


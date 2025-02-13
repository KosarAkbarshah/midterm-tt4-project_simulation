# Layer 1: Build the frontend
FROM node:latest AS builder
WORKDIR /app
COPY ./app/package*.json ./
RUN npm install
COPY ./app/ ./
RUN npm run build 
# The built files are stored in /dist

# Layer 2: Serve with Nginx
FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Replace the default Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 8500
EXPOSE 8500

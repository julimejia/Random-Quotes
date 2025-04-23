FROM node:20-alpine

# Create app directory
WORKDIR /

# Install app dependencies
COPY package*.json ./

# Install dependencies (clean cache to reduce image size)
RUN npm install && npm cache clean --force

# Bundle app source
COPY . .

# Remove potential security risks
RUN rm -rf .env.example Dockerfile

# Create a non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 8080

CMD [ "node", "index.js" ]
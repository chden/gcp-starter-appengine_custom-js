# This docker image is based on an image maintained by Node.js Docker Team, see https://hub.docker.com/_/node.
# Also consider to use the Google-maintained Node.js docker image, see https://github.com/GoogleCloudPlatform/nodejs-docker
FROM node:12-slim


WORKDIR /app

# Copy package.json AND package-lock.json
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Copy app source
COPY . ./


# EXPOSE 8080
CMD [ "npm", "start" ]
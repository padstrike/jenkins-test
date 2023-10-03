# Step 0: Install Docker in Jenkins
FROM jenkins/jenkins:lts AS jenkins-with-docker
USER root
RUN apt-get update -y && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common && \
       curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
       add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
       $(lsb_release -cs) \
       stable" && \
       apt-get update && \
       apt-get -y install docker-ce
USER jenkins

# Step 1: Build the React application
FROM node:16 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# Step 2: Serve the React application using a lightweight node image and serve package
FROM node:16-alpine
WORKDIR /app
COPY --from=build /app/build /app/build
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]

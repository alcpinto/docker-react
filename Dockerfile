#
# Build Phase
#
FROM node:alpine as builder
WORKDIR /usr/app
# Download and install  a dependency
COPY ./package.json ./
RUN npm install
COPY ./ ./
# Tell the image what to do when it starts as a container
RUN npm run build

#
# Run Phase
# Each phase is separated by FROM
#
FROM nginx
# /usr/share/nginx/html (required by nginx)
COPY --from=builder /usr/app/build /usr/share/nginx/html
# default command from nginx is enough for start the aplication


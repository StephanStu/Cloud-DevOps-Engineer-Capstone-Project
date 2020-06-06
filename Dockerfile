# Get the web server nginx to host my side in the cluster, see from https://hub.docker.com/_/nginx
FROM nginx:1.17.6-alpine

# 1st step: delet old index
RUN rm /usr/share/nginx/html/index.html

# 2nd step, copy source code of my side to working directory
COPY index.html /usr/share/nginx/html

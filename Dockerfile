# Get the web server nginx to host my side in the cluster, see from https://hub.docker.com/_/nginx
FROM nginx

# Copy source code of my side to working directory
COPY index.html /usr/share/nginx/html

# Run the web server in the cluster
#RUN rm /usr/share/nginx/html/index.html

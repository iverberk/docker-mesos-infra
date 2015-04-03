FROM dockerfile/ubuntu

WORKDIR /

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx

RUN rm -f /etc/nginx/sites-enabled/default

ADD https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz /consul-template_0.7.0_linux_amd64.tar.gz
RUN tar xzvf /consul-template_0.7.0_linux_amd64.tar.gz --strip-components=1 && rm /consul-template_0.7.0_linux_amd64.tar.gz

ADD reload-nginx.sh /reload-nginx.sh
ADD app-nginx.ctmpl /app-nginx.ctmpl
ADD nginx.conf /etc/nginx/nginx.conf

# Fix ownership
RUN chown nobody /consul-template /reload-nginx.sh /app-nginx.ctmpl /etc/nginx/sites-enabled /var/log/nginx /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 8080

# Run as unprivileged user
USER nobody

# Default command
ENTRYPOINT ["/consul-template"]

# Default parameters
CMD ["-consul", "192.168.33.11:8500", "-template", "/app-nginx.ctmpl:/etc/nginx/sites-enabled/app.conf:/reload-nginx.sh"]
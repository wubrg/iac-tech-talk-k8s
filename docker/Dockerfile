from nginx:1-alpine

COPY index.html /usr/share/nginx/html/index.html

ADD nginx-entrypoint.sh /

EXPOSE 8080

ENTRYPOINT ["sh", "nginx-entrypoint.sh"]

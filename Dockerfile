FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY . .
COPY nginx.conf /etc/nginx/nginx.conf

# install envsubst (gettext) for runtime variable substitution
RUN apk add --no-cache gettext

# copy and register entrypoint which will substitute env vars into the template
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
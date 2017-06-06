FROM maven:3-jdk-8 as maven
MAINTAINER Andy Bavier <andy@opennetworking.org>

COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven/apps
RUN mvn clean install -U

FROM nginx
MAINTAINER Andy Bavier <andy@opennetworking.org>

COPY --from=maven /usr/src/mymaven/repository /usr/share/nginx/html/repository
RUN chown nginx:nginx -R /usr/share/nginx/html/repository

LABEL org.label-schema.name="opencord/mavenrepo" \
      org.label-schema.description="Maven repo with the CORD ONOS apps" \
      org.label-schema.vcs-url="https://gerrit.opencord.org/onos-apps" \
      org.label-schema.vendor="Open Networking Laboratory" \
      org.label-schema.schema-version="1.0"
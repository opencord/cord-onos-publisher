# Dockerfile for onos-apps maven repo

FROM maven:3-jdk-8 as maven
COPY settings.xml /root/.m2/settings.xml
COPY . /mavenwd
WORKDIR /mavenwd/apps
RUN mvn clean install -U

FROM nginx
WORKDIR /usr/share/nginx/html
COPY --from=maven /mavenwd/repository repository
RUN chown nginx:nginx -R /usr/share/nginx/html/repository

# Label image
ARG org_label_schema_schema_version=1.0
ARG org_label_schema_name=opencord/mavenrepo
ARG org_label_schema_version=unknown
ARG org_label_schema_vcs_url=unknown
ARG org_label_schema_vcs_ref=unknown
ARG org_label_schema_build_date=unknown
ARG org_opencord_vcs_commit_date=unknown

LABEL org.label-schema.schema-version=$org_label_schema_schema_version \
      org.label-schema.name=$org_label_schema_name \
      org.label-schema.version=$org_label_schema_version \
      org.label-schema.vcs-url=$org_label_schema_vcs_url \
      org.label-schema.vcs-ref=$org_label_schema_vcs_ref \
      org.label-schema.build-date=$org_label_schema_build_date \
      org.opencord.vcs-commit-date=$org_opencord_vcs_commit_date

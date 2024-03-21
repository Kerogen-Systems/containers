ARG VERSION

FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:${VERSION}

ARG TARGETPLATFORM
ARG CHANNEL

USER root

RUN curl -sSL -o /etc/yum.repos.d/timescale_timescaledb.repo "https://packagecloud.io/install/repositories/timescale/timescaledb/config_file.repo?os=el&dist=8" && \
    microdnf update -y && \
    microdnf install -y timescaledb-2-loader-postgresql-15-2.14.2-0.el8.x86_64.rpm && \
    microdnf install -y timescaledb-2-postgresql-15-2.14.2-0.el8.x86_64.rpm && \
    microdnf install -y timescaledb-toolkit-postgresql-12-1.18.0-0.x86_64.rpm && \
    microdnf clean all

USER 26

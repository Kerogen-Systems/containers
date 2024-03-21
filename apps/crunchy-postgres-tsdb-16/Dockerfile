ARG VERSION

FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:${VERSION}

ARG TARGETPLATFORM
ARG CHANNEL

USER root

# Pull in the official timescaledb2 packages
RUN curl -sSL -o /etc/yum.repos.d/timescale_timescaledb.repo "https://packagecloud.io/install/repositories/timescale/timescaledb/config_file.repo?os=el&dist=8" && \
    microdnf update -y && \
    microdnf install -y timescaledb-2-loader-postgresql-16-2.14.2 && \
    microdnf install -y timescaledb-2-postgresql-16-2.14.2 && \
    microdnf install -y timescaledb-toolkit-postgresql-16-1.18.0 && \
    microdnf clean all

# Set the working directory
WORKDIR /app

# Download pguint from RHEL 8 yum repo
ADD https://download.postgresql.org/pub/repos/yum/16/redhat/rhel-8-x86_64/pguint_16-1.20231206-1PGDG.rhel8.x86_64.rpm /app/

# Install pguint then cleanup
RUN rpm -i /app/pguint_16-1.20231206-1PGDG.rhel8.x86_64.rpm && \
    rm -f /app/pguint_16-1.20231206-1PGDG.rhel8.x86_64.rpm

# Magic user - Do not change
USER 26

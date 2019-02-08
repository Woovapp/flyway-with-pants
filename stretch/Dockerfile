FROM python:2.7.15-stretch

# Ensure Pants runs under the 2.7.15 interpreter.
ENV PANTS_PYTHON_SETUP_INTERPRETER_CONSTRAINTS="['CPython==2.7.15']"

# Install various things Pants requires.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl git openjdk-8-jdk-headless ca-certificates-java wget xml-twig-tools
ENV FLYWAY_VERSION 5.2.3
ENV LIQUIGRAPH_VERSION 3.1.0

WORKDIR /flyway
RUN wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && mv flyway-${FLYWAY_VERSION}/* . \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && ln -s /flyway/flyway /usr/local/bin/flyway

WORKDIR /usr
RUN wget http://repo1.maven.org/maven2/org/liquigraph/liquigraph-cli/${LIQUIGRAPH_VERSION}/liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz \
  && tar xzf liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz

COPY migrate_neo4j.sh /usr/liquigraph-cli/

RUN curl -O https://dl.minio.io/server/minio/release/linux-amd64/minio \
  && chmod +x minio \
  && mv minio /usr/local/bin/minio \
  && useradd -r minio-user -s /sbin/nologin \
  && chown minio-user:minio-user /usr/local/bin/minio \
  && mkdir -p /usr/local/share/minio \
  && chown minio-user:minio-user /usr/local/share/minio

ENV MINIO_ACCESS_KEY="WOOV-CI"
ENV MINIO_SECRET_KEY="WOOVWOOV"

WORKDIR /pants
RUN curl -L -O https://pantsbuild.github.io/setup/pants && chmod +x pants && touch pants.ini

CMD bash

FROM python:2.7.15-slim-stretch

# Ensure Pants runs under the 2.7.15 interpreter.
ENV PANTS_PYTHON_SETUP_INTERPRETER_CONSTRAINTS="['CPython==2.7.15']"

RUN mkdir -p /usr/share/man/man1

# Install various things Pants requires.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk-headless ca-certificates-java wget xml-twig-tools curl

ENV FLYWAY_VERSION 5.1.4
ENV LIQUIGRAPH_VERSION 3.0.3

WORKDIR /flyway
RUN wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && mv flyway-${FLYWAY_VERSION}/* . \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && sed -i 's/bash/sh/' /flyway/flyway \
  && ln -s /flyway/flyway /usr/local/bin/flyway

WORKDIR /usr
RUN wget http://repo1.maven.org/maven2/org/liquigraph/liquigraph-cli/${LIQUIGRAPH_VERSION}/liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz \
  && tar xzf liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz

COPY migrate_neo4j.sh /usr/liquigraph-cli/

CMD bash

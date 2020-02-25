FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u242-b08-slim as runner

ENV SBT_VERSION=1.3.4 \
	SBT_HOME=/usr/local/sbt \
	PATH=${PATH}:${SBT_HOME}/bin \
	FLYWAY_VERSION=6.2.3 \
	LIQUIGRAPH_VERSION=3.1.0 \
	NODE_VERSION=12.16.0 \
	YARN_VERSION=1.22.0

RUN apt-get update && apt-get install -y curl wget gnupg ca-certificates tar gzip --no-install-recommends && rm -rf /var/lib/apt/lists/*
WORKDIR /root
ADD install_sbt.sh .
RUN ./install_sbt.sh

WORKDIR /flyway
ADD install_flyway.sh .
ADD https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz flyway-commandline-${FLYWAY_VERSION}.tar.gz
RUN ./install_flyway.sh

WORKDIR /usr
ADD https://repo1.maven.org/maven2/org/liquigraph/liquigraph-cli/${LIQUIGRAPH_VERSION}/liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz 
RUN tar xzf liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz && rm liquigraph-cli-${LIQUIGRAPH_VERSION}-bin.tar.gz
COPY migrate_neo4j.sh /usr/liquigraph-cli/

WORKDIR /root
ADD install_nodejs.sh .
RUN ./install_nodejs.sh

RUN yarn global add artillery artillery-plugin-metrics-by-endpoint

ADD install_grpc_health_probe.sh .
RUN ./install_grpc_health_probe.sh

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8
RUN locale-gen en_US.UTF-8
ENV LC_ALL='en_US.utf8'

# Install GDAL dependencies
RUN apt-get update && apt-get install -y python3-pip libgdal-dev locales

# Install git-core so we can clone stuff in CI
RUN apt-get install -y --no-install-recommends git-core

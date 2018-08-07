FROM anapsix/alpine-java:8_jdk

ENV FLYWAY_VERSION 5.1.4
ENV LIQUIGRAPH_VERSION 3.0.3

# Install various things Pants requires.
RUN apk update && apk add \
     bash \
     curl \
     gcc \
     git \
     libffi-dev \
     linux-headers \
     musl-dev \
     openssl \
     openssl-dev \
     python \
     python-dev

WORKDIR /pants

RUN curl -L -O https://pantsbuild.github.io/setup/pants && \
	chmod +x pants && \
	touch pants.ini && \
	sed -i -e "s|setuptools==5.4.1|setuptools==18.5|" pants && \
	./pants -V

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
RUN export PATH=$PATH:/usr/liquigraph-cli

COPY migrate_neo4j.sh /usr/liquigraph-cli/

CMD bash
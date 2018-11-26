FROM pantsbuild/centos6

ENV FLYWAY_VERSION 5.2.3
ENV LIQUIGRAPH_VERSION 3.1.0

# Install various things Pants requires.
RUN yum install -y wget local-perl-XML-Twig

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

CMD bash
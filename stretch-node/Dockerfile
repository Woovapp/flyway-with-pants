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

WORKDIR /pants
RUN curl -L -O https://pantsbuild.github.io/setup/pants && chmod +x pants && touch pants.ini

#Install NodeJS
RUN apt-get update -yq \
    && apt-get install gnupg apt-transport-https -yq \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get install nodejs yarn -yq \
    && yarn global add artillery@v1.6.0-25 artillery-plugin-metrics-by-endpoint \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN curl -s https://api.github.com/repos/grpc-ecosystem/grpc-health-probe/releases/latest \
  | grep browser_download_url \
  | grep linux-amd64 \
  | cut -d '"' -f 4 \
  | wget -O /bin/grpc-health-probe -qi -
RUN chmod +x /bin/grpc-health-probe

CMD bash

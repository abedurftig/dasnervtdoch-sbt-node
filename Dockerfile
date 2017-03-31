#
# SBT image based on Oracle JRE 8
# Based on https://github.com/1science/docker-sbt

FROM 1science/java:oracle-jre-8

ENV SBT_VERSION 0.13.13
ENV SCALA_VERSION 2.11.8
ENV SBT_HOME /usr/local/sbt

ENV NODE_VERSION=6.7.0
ENV NODE_HOME=/usr/local/nodejs

ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:${NODE_HOME}/node-v${NODE_VERSION}-linux-x64/bin

ENV JAVA_OPTS -Xmx2g

# Install sbt
RUN curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /tmp/ && rm -r /usr/local && mv /tmp/sbt-launcher-packaging-$SBT_VERSION /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

# Install nodejs

RUN apk update
RUN apk add --no-progress curl make gcc g++ python linux-headers gnupg libstdc++

RUN mkdir -p ${NODE_HOME} && curl http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar xvzf - -C ${NODE_HOME} && \
    echo -ne "- with node $NODE_VERSION\n" >> /root/.built

WORKDIR /root
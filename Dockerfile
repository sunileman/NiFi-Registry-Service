FROM openjdk:8-jdk-alpine


ARG UID=1000
ARG GID=1000

ENV NIFI_REGISTRY_VERSION=0.3.0.1.0.0.0-90


ENV NIFI_REGISTRY_BASE_DIR /opt/nifi-registry

ENV NIFI_REGISTRY_SCRIPTS /opt/scripts
ENV NIFI_REGISTRY_HOME $NIFI_REGISTRY_BASE_DIR/nifi-registry-$NIFI_REGISTRY_VERSION

RUN apk add --no-cache bash wget


RUN addgroup -g $GID nifi || groupmod -n nifi `getent group $GID | cut -d: -f1`
RUN adduser -S -H -G nifi nifi


RUN mkdir -p $NIFI_REGISTRY_BASE_DIR
RUN mkdir -p $NIFI_REGISTRY_SCRIPTS


ADD ./scripts $NIFI_REGISTRY_SCRIPTS

RUN wget https://sunileman1.s3-us-west-2.amazonaws.com/CEM/JAVA/nifi-registry-$NIFI_REGISTRY_VERSION-bin.tar.gz -P $NIFI_REGISTRY_BASE_DIR

run tar -xzf $NIFI_REGISTRY_BASE_DIR/nifi-registry-$NIFI_REGISTRY_VERSION-bin.tar.gz

#ADD ./target/nifi-registry-*-bin.tar.gz $NIFI_REGISTRY_BASE_DIR

RUN chown -R nifi:nifi $NIFI_REGISTRY_BASE_DIR
RUN chown -R nifi:nifi $NIFI_REGISTRY_SCRIPTS

USER nifi

RUN ["chmod", "+x", "/opt/scripts/start.sh"]

CMD ${NIFI_REGISTRY_SCRIPTS}/start.sh

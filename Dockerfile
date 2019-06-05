FROM anapsix/alpine-java:8_server-jre

#https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.6/elasticsearch-2.4.6.tar.gz
#https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$VERSION/elasticsearch-$VERSION.tar.gz
ENV VERSION 2.4.6
#ENV VERSION 1.7.4
#ENV VERSION 1.7.6
ENV ES_PKG_NAME elasticsearch-$VERSION
#ENV ES_PKG_NAME elasticsearch-2.4.6
# install elasticsearch
# RUN \
#   apk upgrade --update && \
#   apk add --update curl && \
#   cd / && \
#   curl -o $ES_PKG_NAME.tar.gz https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
#   tar xvzf $ES_PKG_NAME.tar.gz && \
#   rm -f $ES_PKG_NAME.tar.gz && \
#   mv /$ES_PKG_NAME /elasticsearch && \
#   apk del curl
#https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.6.tar.gz
# RUN \
#   apk upgrade --update && \
#   apk add --update curl && \
#   cd / && \
#   curl -o $ES_PKG_NAME.tar.gz https://download.elastic.co/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
#   tar xvzf $ES_PKG_NAME.tar.gz && \
#   rm -f $ES_PKG_NAME.tar.gz && \
#   mv /$ES_PKG_NAME /elasticsearch && \
#   apk del curl

# RUN \
#   apk upgrade --update && \
#   apk add --update curl tar && \
#   cd / && \
#   curl -o $ES_PKG_NAME.tar.gz https://download.elastic.co/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
#   tar -xvzf $ES_PKG_NAME.tar.gz && \
#   rm -f $ES_PKG_NAME.tar.gz && \
#   mv /$ES_PKG_NAME /elasticsearch && \
#   apk del curl


COPY $ES_PKG_NAME $HOME/elasticsearch

WORKDIR elasticsearch
# Create a group and user
RUN addgroup -S elasticsearch && adduser -S elasticsearch -G elasticsearch

# Tell docker that all future commands should run as the appuser user
VOLUME ["/data"]

RUN chown -R elasticsearch:elasticsearch .

USER elasticsearch

# config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# # default command
CMD ["elasticsearch/bin/elasticsearch"]

# expose ports
#   - 9200: HTTP
#   - 9300: native transport
EXPOSE 9200
EXPOSE 9300
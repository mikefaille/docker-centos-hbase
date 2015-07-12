FROM mikefaille/centos-java:latest
MAINTAINER michael@faille.io <michael@faille.io>

ENV HBASE_VERSION 1.1.1
ENV HBASE_HOME /hbase/hbase-$HBASE_VERSION
ENV HBASE $HBASE_HOME



# hbase fondation
RUN mkdir /hbase && cd /hbase && wget http://apache.mirror.vexxhost.com/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz  && tar -xzf hbase-$HBASE_VERSION-bin.tar.gz && rm hbase-$HBASE_VERSION-bin.tar.gz &&\
    mkdir /data/persistant/hbase

# HBASE Setup
VOLUME /data/persistant/hbase
ADD conf/hbase-site.xml /hbase/hbase-$HBASE_VERSION/conf/hbase-site.xml
# ADD lib/hadoop-lzo-0.4.20-SNAPSHOT.jar /hbase/hbase-$HBASE_VERSION/lib/hadoop-lzo-0.4.20-SNAPSHOT.jar
# ADD lib/libgplcompression.so /hbase/hbase-$HBASE_VERSION/lib/native/libgplcompression.so
EXPOSE 60000
EXPOSE 60010
EXPOSE 60030

# Supervisor
ADD conf/supervisor-hbase.ini /etc/supervisord.d/hbase.ini

# Insert startup files
ADD conf/start-hbase.sh /data/start-hbase.sh


#env COMPRESSION=gzip  /data/start-opentsdb.sh

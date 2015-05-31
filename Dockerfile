FROM	ubuntu:14.04

ENV     DEBIAN_FRONTEND noninteractive
ENV	JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN	apt-get update && \
	apt-get install -y openjdk-7-jre-headless supervisor wget

ENV	ES_PKG_NAME elasticsearch-1.5.2

RUN	wget -q https://download.elastic.co/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
	tar -xzf $ES_PKG_NAME.tar.gz && \
	rm -f $ES_PKG_NAME.tar.gz && \
	mv /$ES_PKG_NAME /elasticsearch

RUN	cd /elasticsearch && \
	bin/plugin --install jdbc --url http://xbib.org/repository/org/xbib/elasticsearch/plugin/elasticsearch-river-jdbc/1.5.0.5/elasticsearch-river-jdbc-1.5.0.5-plugin.zip

RUN	wget -q http://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/sqljdbc_4.0.2206.100_enu.tar.gz && \
	tar -xzf sqljdbc_4.0.2206.100_enu.tar.gz && \
	mv sqljdbc_4.0/enu/sqljdbc4.jar /elasticsearch/plugins/jdbc/

ENV	KIBANA_PKG_NAME kibana-4.0.2-linux-x64

RUN	wget -q https://download.elastic.co/kibana/kibana/$KIBANA_PKG_NAME.tar.gz && \
	tar -xzf $KIBANA_PKG_NAME.tar.gz && \
	rm -rf $KIBANA_PKG_NAME.tar.gz && \
	mv /$KIBANA_PKG_NAME /kibana

ADD	supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE  5601
EXPOSE 	9200
EXPOSE 	9300 

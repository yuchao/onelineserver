#!/bin/bash

ELASTICSEARCH_VER="0.19.7"

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }


cd /opt
sudo curl http://cloud.github.com/downloads/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VER}.tar.gz | tar zxv
sudo ln -s elasticsearch-${ELASTICSEARCH_VER}/ elasticsearch

sudo curl -k -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz
sudo mv *servicewrapper*/service elasticsearch/bin/
sudo rm -Rf *servicewrapper*
sudo /opt/elasticsearch/bin/service/elasticsearch install

sudo ln -s `readlink -f elasticsearch/bin/service/elasticsearch` /usr/bin/elasticsearch_ctl
sudo sed -i -e 's|# cluster.name: elasticsearch|cluster.name: elastic_search|' /opt/elasticsearch/config/elasticsearch.yml
sudo /etc/init.d/elasticsearch start

curl -XGET 'http://localhost:9200/_cluster/health?pretty=true'

echo "###############################################"
echo "         git installation is complete!         "
echo "###############################################"
1. Start Elasticsearch and Kibana containers

```
docker run -d -p 127.0.0.1:9200:9200 --name=elasticsearch elasticsearch
docker run -d -p 80:80 --link elasticsearch:elasticsearch --name=kibana kibana  
```

2. Download and configure elasticsearch-jdbc, for SQL Server use [this](https://github.com/efouts/docker-elasticsearch-jdbc/blob/master/setup-elasticsearch-jdbc-sqlserver)

3. Run an importer per query on host machine per elasticsearch-jdbc instructions, examples are [here](https://github.com/jprante/elasticsearch-jdbc/tree/master/bin)

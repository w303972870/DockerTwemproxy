```
docker pull registry.cn-hangzhou.aliyuncs.com/server_repertory/twemproxy:latest
```

#### 先确认端口是否能通，不能就打开端口
```
firewall-cmd --zone=public --add-port=26379/tcp --permanent && firewall-cmd --reload
firewall-cmd --zone=public --add-port=6370/tcp --permanent && firewall-cmd --reload
firewall-cmd --zone=public --add-port=22121/tcp --permanent && firewall-cmd --reload
```

```
docker run -dit  --net host -p 22121:22121 -v /root/twemproxy/redis_master.conf:/data/twemproxy/redis_master.conf  registry.cn-hangzhou.aliyuncs.com/server_repertory/twemproxy:latest
```

提供一个简单的配置文件：

```
redis_master:
  listen: 0.0.0.0:22121
  hash: fnv1a_64
  distribution: ketama
  auto_eject_hosts: true
  redis: true
  redis_auth: 123456
  server_retry_timeout: 2000
  server_failure_limit: 1
  servers:
    - 192.168.12.2:6370:1
    - 192.168.12.3:6370:1
    - 192.168.12.4:6370:1
```

# A docker swarm sample

This project consists of a 3 node docker swarm and a single server for shared services such as a database, rabbit server, etc.

* haproxy
* UI
* API

## Build

## Start

### Catch-All
Build
```
docker build -t registry.swarm.dev:5000/catchall:1 .
docker push registry.swarm.dev:5000/catchall:1
```

```
docker service create -p 1111 -e PORT=1111 --replicas=3 --name catchall registry.swarm.dev:5000/catchall:1
```

### UI

Build
```
docker build -t registry.swarm.dev:5000/ui:1 .
docker push registry.swarm.dev:5000/ui:1
```

```
docker service create -p 3000 -e PORT=3000 --replicas=3 --name ui registry.swarm.dev:5000/ui:1

```

### API

```
docker service create --name api api:1 -p 3000:3000 npm start

```
### haproxy

Build
```
docker build -t registry.swarm.dev:5000/haproxy:test1 .
docker push registry.swarm.dev:5000/haproxy:test1
```

deploy
```
docker service create --name haproxy -p 80:80 -p 443:443 -p 1234:1234 -e UI=ui:3000 -e CATCHALL=catchall:1111 registry.swarm.dev:5000/haproxy:test1
```

## Discovery
* What happens if one of the UI containers return a 500?

# A docker swarm sample

This project consists of a 3 node docker swarm for testing swarm mode implemented using VirtualBox and Vagrant. It also includes a `services` to run a load balancer or any other shared services.

services (192.168.77.110)
* Docker Private Registry: registry.swarm.dev:5000
* haproxy:
  * catchall: https://192.168.77.110
  * ui: https://192.168.77.110/ui

swarm: (192.168.77.120-122)
* catch-all
* ui

![swarmify nodes](swarmify.png)

## Quick start

From the repo folder

```
$ vagrant up
$ vagrant ssh manager1
$ cd /vagrant
$ ./deploy.sh
$ docker service ls
```
The last step should confirm that all the services have started.

```
vagrant@manager1:/vagrant$ docker service ls
ID            NAME      REPLICAS  IMAGE                                  COMMAND
0dcty3nrr0ca  haproxy   3/3       registry.swarm.dev:5000/haproxy:test1
btva0v1ftuki  ui        3/3       registry.swarm.dev:5000/ui:1
dvaz6tp8ekt0  catchall  3/3       registry.swarm.dev:5000/catchall:1
```

Verify the services from the host. Running the command multiple times will demonstrate the swarm LB by returning a different container host name with each request.

Catch All service
```
curl --insecure https://192.168.77.110/
```

UI Service
```
curl --insecure https://192.168.77.110/ui
```

## Update the UI

Make a change to the ui

build
```
docker build -t registry.swarm.dev:5000/ui:2 .
docker push registry.swarm.dev:5000/ui:2
```

upgrade
```
docker service update --image ui:2 ui
```

## Visualizer
```
docker run -it -d --name visualizer -p 8080:8080 -e HOST=192.168.77.120 -v /var/run/docker.sock:/var/run/docker.sock manomarks/visualizer
```

## Discovery
* What happens if one of the UI containers return a 500 consistently from the LB perspective?
* Does it make sense to run multiple copies of haproxy? One for each node in the swarm?

```
for ((i=1;i<=100;i++)); do   curl --insecure https://192.168.77.110; echo $'\n'; done
for ((i=1;i<=100;i++)); do   curl --insecure https://192.168.77.110/ui; echo $'\n'; done

for ((i=1;i<=100;i++)); do   curl http://192.168.77.120:1111; echo $'\n'; done
for ((i=1;i<=100;i++)); do   curl http://192.168.77.120:3000/ui; echo $'\n'; done
```

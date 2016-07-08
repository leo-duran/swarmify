# A docker swarm sample

This project consists of a 3 node docker swarm for testing swarm mode implemented using VirtualBox and Vagrant.

The following services are being managed by the swarm

* haproxy
* catch-all
* ui

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

## Discovery
* What happens if one of the UI containers return a 500 consistently from the LB perspective?
* Does it make sense to run multiple copies of haproxy? One for each node in the swarm?

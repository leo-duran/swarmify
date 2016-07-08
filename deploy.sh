# catch-all

cd /vagrant/catch-all

docker service rm catchall

docker build -t registry.swarm.dev:5000/catchall:1 .
docker push registry.swarm.dev:5000/catchall:1

docker service create -p 1111 -e PORT=1111 --replicas=3 --name catchall registry.swarm.dev:5000/catchall:1

# ui

cd ../ui

docker service rm ui

docker build -t registry.swarm.dev:5000/ui:1 .
docker push registry.swarm.dev:5000/ui:1

docker service create -p 3000 -e PORT=3000 --replicas=3 --name ui registry.swarm.dev:5000/ui:1

# haproxy

cd ../haproxy

docker service rm haproxy

docker build -t registry.swarm.dev:5000/haproxy:test1 .
docker push registry.swarm.dev:5000/haproxy:test1

docker service create --name haproxy -p 80:80 -p 443:443 -p 1234:1234 -e UI=ui:3000 -e CATCHALL=catchall:1111 registry.swarm.dev:5000/haproxy:test1

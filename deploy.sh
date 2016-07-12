# catch-all

cd /vagrant/catch-all

docker service rm catchall

docker build -t registry.swarm.dev:5000/catchall:1 .
docker push registry.swarm.dev:5000/catchall:1

docker service create -p 1111:1111 -e PORT=1111 --replicas=3 --name catchall registry.swarm.dev:5000/catchall:1

# ui

cd ../ui

docker service rm ui

docker build -t registry.swarm.dev:5000/ui:1 .
docker push registry.swarm.dev:5000/ui:1

docker service create -p 3000:3000 -e PORT=3000 --replicas=3 --name ui registry.swarm.dev:5000/ui:1

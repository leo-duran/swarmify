sudo apt-get update
sudo curl -fsSL https://test.docker.com/ | sh

sudo usermod -aG docker vagrant

# registry
echo "192.168.77.110  registry.swarm.dev" >> /etc/hosts

export DOCKER_REPO=registry.swarm.dev:5000
mkdir -p /etc/docker/certs.d/$DOCKER_REPO
cp /vagrant/ca.crt /etc/docker/certs.d/$DOCKER_REPO/ca.crt

sudo mkdir /certs
sudo cp /vagrant/certs/domain.crt /certs
sudo cp /vagrant/certs/domain.key /certs
chown vagrant:vagrant /certs

docker run -d -p 5000:5000 --restart=always --name registry \
  -v /certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2

curl -L https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# haproxy

cd /vagrant/haproxy

docker build -t registry.swarm.dev:5000/swarm-haproxy:1 .
docker push registry.swarm.dev:5000/swarm-haproxy:1

docker run -d --name swarm-haproxy -p 80:80 -p 443:443 -p 1234:1234 registry.swarm.dev:5000/swarm-haproxy:1

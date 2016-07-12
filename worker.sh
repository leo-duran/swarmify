sudo apt-get update
sudo curl -fsSL https://test.docker.com/ | sh

sudo docker swarm join 192.168.77.120:2377
sudo usermod -aG docker vagrant

# Setup the private pluralsight registry
echo "192.168.77.110  registry.swarm.dev" >> /etc/hosts

export DOCKER_REPO=registry.swarm.dev:5000
mkdir -p /etc/docker/certs.d/$DOCKER_REPO
cp /vagrant/ca.crt /etc/docker/certs.d/$DOCKER_REPO/ca.crt

curl -L https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

sudo apt-get update
sudo curl -fsSL https://test.docker.com/ | sh

sudo docker swarm init --listen-addr 192.168.77.110:2377

# Setup the private pluralsight registry
echo "10.107.7.144  registry.pluralsight.private" >> /etc/hosts

export DOCKER_REPO=registry.pluralsight.private:5000
mkdir -p /etc/docker/certs.d/$DOCKER_REPO
cp /vagrant/ca.crt /etc/docker/certs.d/$DOCKER_REPO/ca.crt

curl -L https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker vagrant

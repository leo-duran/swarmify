docker run -it -d --name visualizer -p 8080:8080 -e HOST=192.168.77.120 -v /var/run/docker.sock:/var/run/docker.sock manomarks/visualizer

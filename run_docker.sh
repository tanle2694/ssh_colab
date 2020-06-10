docker build . -t go_docker
docker run --rm -p 7000:7000 -p 8000:8000 -p 8001:8001 -p 4443:4443 -p 10000-10050:10000-10050 -t go_docker
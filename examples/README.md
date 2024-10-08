# Monoid Ngrok Server Example

## Prerequisites

- Docker Client

## Build

```shell
docker build .. --file ../Dockerfile.server --tag monoid/ngrok-server:latest
```

## Run

```shell
docker run --rm \
           --publish 80:80 \
           --publish 443:443 \
           --publish 4443:4443 \
           --name ngrok-server \
           monoid/ngrok-server \
           -domain=ngrok.me
```

## Test

```shell
# Configure `hosts`
sudo cat >> /etc/hosts << EOF
127.0.0.1 ngrok.me
127.0.0.1 test.ngrok.me
EOF

# Start client
make -C .. client
../nrk -config=client.config.test.yaml start test

# Start dummy http
go run dummy_http.go

# Visit endpoint
curl http://test.ngrok.me/ping  # pong
```

## Clean

```shell
# Remove docker image
docker image rm monoid/ngrok-server

# Restore hosts by removing `ngrok.me` related config in `/etc/hosts`
sudo vim /etc/hosts
```

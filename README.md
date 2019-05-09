# docker-apache-webdav

docker image for an apache based webdav server

## How to start

```sh
docker run \
    -v webdav:/webdav \
    -v $PWD/htpasswd:/htpasswd:ro \
    -e VIRTUAL_HOST=example.com \
    -p 8080:80 siticom/apache-webdav
```
export DOCKER_BUILDKIT=1
docker build -t milangress/discoart:preload-extra -f preload-extra.Dockerfile .

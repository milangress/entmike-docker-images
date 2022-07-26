export DOCKER_BUILDKIT=0
docker build -t milangress/discoart:runpod --build-arg base_image=milangress/discoart:preload -f Dockerfile .

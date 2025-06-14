docker build -t claude-desktop .
docker run -it \
  --rm \
  --env DISPLAY=$DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --device /dev/dri \
  --name claude-desktop \
  claude-desktop


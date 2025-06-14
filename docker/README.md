# Claude Desktop in Docker (Arch Linux)

This repository contains a Docker setup to build and run the `claude-desktop-native` application in an Arch Linux environment.

## 📦 What's Included

- **Arch Linux base image**
- Installs necessary dependencies (`yay`, `nodejs`, `rust`, etc.)
- Builds and installs `claude-desktop-native` from source
- Adds a non-root user `claude`
- Automatically launches the app with `--no-sandbox` on container start
- Supports GUI via host X11 forwarding

## 🚀 Getting Started

### 1. Build the Docker Image
```bash
cd docker
docker build -t claude-desktop .
```

### 2. Run the Container with X11 Support
```bash
xhost +local:
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device /dev/dri \
  claude-desktop
```

This will launch `claude-desktop-native` with GUI support.

## 🐧 Notes

- Requires X11 to be running on the host (tested on Ubuntu).
- App is launched with `--no-sandbox` due to container namespace restrictions.

## 📁 Files

- `Dockerfile` – builds the Arch-based environment
- `start.sh` – (optional) helper script to build and run the container

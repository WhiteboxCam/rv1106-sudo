# Luckfox Pico SDK Development Container

This directory contains configuration files for a Visual Studio Code Development Container that provides all the necessary dependencies to build the Luckfox Pico SDK.

## Requirements

- Docker Desktop or Docker Engine installed on your host machine
- Visual Studio Code with the "Remote - Containers" extension

## Getting Started

1. Open VS Code and install the "Remote - Containers" extension if you haven't already
2. Open the Luckfox Pico SDK repository in VS Code
3. When prompted, click "Reopen in Container", or press F1 and select "Remote-Containers: Reopen in Container"
4. Wait for the container to build (this may take a few minutes the first time)
5. Once inside the container, you can use the terminal to run the build commands:

```bash
# Configure the build
./build.sh lunch

# Build the SDK
./build.sh
```

## Additional Information

- The container includes all dependencies mentioned in the Luckfox Pico SDK README
- It uses Ubuntu 22.04 as the base image, as recommended by the SDK documentation
- Any files you modify in the container are also modified in your host file system
- The workspace is mounted as a volume, so your changes will persist even if the container is rebuilt

## Customization

You can customize the devcontainer configuration by modifying:

- `devcontainer.json`: VS Code settings and container configuration
- `Dockerfile`: Container image definition and installed packages

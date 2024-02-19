# Seismology-Docker

Seismology-Docker is a docker image with seismology-related packages installed.

## Requirements

* Docker with BuildKit
* X Server (for GUI support on Windows and macOS)
    * For Windows, `VcXsrv`.
    * For Linux, it is installed by default on most of Linux distributions.
    * For macOS, `XQuartz`.
* xhost
    * For Windows, it is part of `VcXsrv`.
    * For Arch-based distros, `xorg-xhost`.
    * For Debian-based distros, `x11-server-utils`.
    * For macOS, it is part of `XQuartz`.

## Requirements installation

### Windows

#### Install VcXsrv (X Server)
1. Download and install latest version of [VcXsrv](https://sourceforge.net/projects/vcxsrv/files/latest/download).
2. Make sure that `Full` dropdown selected and click `Next`.
3. Leave the Destination Folder untouched and click `Install`.
4. After the installation process successfully completes you may click `Close`.
5. Configure VcXsrv with the application named `XLaunch`.
6. Make sure that `Multiple windows` option selected.
7. Set `Display number` to `0` and click `Next`.
8. Make sure that `Start no client` option selected and click `Next`.
9. Select `Disable access control` option and click `Next`.
10. Click `Finish`.
11. Now you should see an `X icon` appears on your taskbar.  
This indicates that the VcXsrv (X Server) is running.

> [!NOTE]
> If you killed the X Server or the X icon disappeared from the taskbar, just relaunch `XLaunch` and follow the configuration steps.

#### Install Docker Desktop
1. Download and install latest version of [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/).
2. Make sure that `Use WSL 2 instead of Hyper-V` option selected and click `Ok`.
3. After the installation process successfully completes you may click `Close`.
4. Reboot the PC.
5. Launch `Docker Desktop`.
6. Read the terms and conditions completely and click `Accept`.
7. Click `Continue without signing in`.
8. Click `Skip survey`.
9. Now you should see an `Docker icon` appears on your taskbar.  
This indicates that the Docker Desktop (with Docker Engine) is running.
10. You may close Docker Desktop window when you confirm that Docker Desktop is running on the taskbar icon.

> [!NOTE]
> If you killed the Docker Desktop or the Docker icon disappeared from the taskbar, just relaunch `Docker Desktop`.

### macOS

#### Install XQuartz (X Server)
1. Download and install latest version of [XQuartz](https://www.xquartz.org/index.html).
2. Click `Continue`.
3. Read the information carefully and click `Continue`.
4. Read the terms and conditions carefully and click `Continue`.
5. Click `Agree`.
6. Click `Install`.
7. After the installation process successfully completes you may click `Close`.
8. Reboot the PC.
9. Open Terminal.
```shell
# Enable Indirect GLX
$ defaults write org.xquartz.X11 enable_iglx -boolean true

# Allow connections from network
$ defaults write org.xquartz.X11 nolisten_tcp -boolean false
```
10. Reboot the PC.

## Installation

### Windows

> [!IMPORTANT]
> Make sure that the Docker Engine is running before issuing `docker` command.

1. Run PowerShell.

```shell
# Clone this repository
PS > git clone https://github.com/yurical/seismology-docker.git

Cloning into 'seismology-docker'...
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 8 (delta 0), reused 8 (delta 0), pack-reused 0
Receiving objects: 100% (8/8), 4.42 KiB | 4.42 MiB/s, done.

# Go to the directory where you extracted `seismology-docker.zip`
PS > cd seismology-docker

# Make sure that `Dockerfile` exists in the current directory
PS > Get-ChildItem

    Directory: ...

Mode       LastWriteTime       Length Name
----       -------------       ------ ----
-a---                ...          ... Dockerfile
-a---                ...          ... LICENSE
-a---                ...          ... README.md
-a---                ...          ... requirements.txt

# Build a docker image
PS > docker buildx build . --network host --tag seismology

[+] Building 137.1s (13/13) FINISHED                                                                     docker:default
 => [internal] load build definition from Dockerfile                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => [1/7] FROM docker.io/library/python:3.10-slim-bookworm@sha256:e53bad75661571d23d9fd632d10f192b09228f31b14af1f  7.7s
 => [2/7] RUN apt-get update                                                                                       2.8s
 => [3/7] RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q     dbus     pkg-config     libxcb*-dev     l  71.6s
    ...
 => => naming to docker.io/library/seismology                                                                      0.0s

View build details: ...

# Once build finishes, make sure that `seismology` docker image exists
PS > docker image ls

REPOSITORY   TAG      IMAGE ID   CREATED   SIZE
seismology   latest   ...        ...       <about a few GB>
```

### Linux

> [!IMPORTANT]
> Make sure that the docker.service is running before issuing `docker` command.

```shell
# Clone this repository
$ git clone https://github.com/yurical/seismology-docker.git

Cloning into 'seismology-docker'...
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 8 (delta 0), reused 8 (delta 0), pack-reused 0
Receiving objects: 100% (8/8), 4.42 KiB | 4.42 MiB/s, done.

# Go to the directory where you extracted `seismology-docker.zip`
$ cd seismology-docker

# Make sure that `Dockerfile` exists in the current directory
$ ls
Dockerfile  LICENSE  README.md  requirements.txt

# Build a docker image
$ docker buildx build . --network host --tag seismology

[+] Building 137.1s (13/13) FINISHED                                                                     docker:default
 => [internal] load build definition from Dockerfile                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => [1/7] FROM docker.io/library/python:3.10-slim-bookworm@sha256:e53bad75661571d23d9fd632d10f192b09228f31b14af1f  7.7s
 => [2/7] RUN apt-get update                                                                                       2.8s
 => [3/7] RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q     dbus     pkg-config     libxcb*-dev     l  71.6s
    ...
 => => naming to docker.io/library/seismology                                                                      0.0s

View build details: ...

# Once build finishes, make sure that `seismology` docker image exists
$ docker image ls

REPOSITORY   TAG      IMAGE ID   CREATED   SIZE
seismology   latest   ...        ...       <about a few GB>
```

## Usage

> [!IMPORTANT]
> Make sure that the X Server and Docker Engine is running before issuing `docker` command.

### Windows

```shell
# Start the docker container with bash entrypoint
PS > docker run -e DISPLAY="host.docker.internal:0.0" --shm-size 4G -it --rm --entrypoint bash seismology

# Now it continues on bash as root
root@67ce68476fdc:/work＃

# Run some applications to confirm GUI works
root@67ce68476fdc:/work＃ geany

# Type exit to quit from container
root@67ce68476fdc:/work＃ exit

PS >
```

### Linux
```shell
# Adjust the permissions the X server host
$ xhost +local:docker

# Start the docker container with bash entrypoint
$ docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY --shm-size 4G -it --rm --entrypoint bash seismology

# Now it continues on bash as root
root@67ce68476fdc:/work＃

# Run some applications to confirm GUI works
root@67ce68476fdc:/work＃ geany

# Type exit to quit from container
root@67ce68476fdc:/work＃ exit

$

# You can revert the permissions after you are finished using the container (If you concerned)
$ xhost -local:docker
```

## Troubleshooting

### dial unix /var/run/docker.sock: connect: permission denied

```shell
# Create a docker group
$ sudo groupadd -f docker

# Add docker group to the current user
$ sudo usermod -aG docker "${USER}"

# Change /var/run/docker.sock owner group
$ sudo chown root:docker /var/run/docker.sock

# Apply the changes to groups
$ newgrp docker

# Restart the docker service
$ sudo systemctl restart docker
```

### E: Failed to fetch http://deb.debian.org/debian/pool/main/*.deb  Cannot initiate the connection to deb.debian.org:80. - connect (101: Network is unreachable)

Try the build command again.

## TODO

* Add further instructions for macOS

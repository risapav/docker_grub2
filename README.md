# grub2
grub2 payload builder using docker 


## Clone

Make sure git is installed.
```sh
git clone https://github.com/risapav/docker_grub2 && cd docker_grub2
```

## Build Docker container

It is very easy:

```sh
docker build -t docker_grub2 .
```

or:

```sh
docker build https://github.com/risapav/docker_grub2.git -t grub2-sdk
```

## Run grub2-sdk environment

Run Docker inside project directory. ST-link dongle should be plugged in USB.

```sh
docker run --rm --privileged \
	-p 4500:4500 \
	-v /dev/bus/usb:/dev/bus/usb \
	-v $PWD:/home/grub2 \
	-w /home/grub2 \
	-it grub2-sdk
```

# grub2
grub2 payload builder using docker 


## Clone

Make sure git is installed.
```sh
git clone https://github.com/risapav/grub2-sdk && cd grub2-sdk
```

## Build Docker container

It is very easy:

```sh
docker build -t grub2-sdk .
```

or:

```sh
docker build https://github.com/risapav/grub2-sdk.git -t grub2-sdk
```

## Run grub2-sdk environment

Run Docker inside project directory. ST-link dongle should be plugged in USB.

```sh
docker run --rm --privileged -d \
	-it grub2-sdk \
	-p 4500:4500 \
	-v /dev/bus/usb:/dev/bus/usb \
	-v $PWD:/home/cb/prj \
	-w /home/cb 
```
FROM debian:bookworm-slim

MAINTAINER Pavol Risa "risapav at gmail"

# Prepare directory for tools
ARG GRUB2_PATH=/home/grub2
ARG PROJECT_PATH=${GRUB2_PATH}/prj
ARG BUILD_PATH=${GRUB2_PATH}/build
ARG SCRIPTS_PATH=${GRUB2_PATH}/scripts

RUN mkdir -p ${BUILD_PATH} ${SCRIPTS_PATH} ${PROJECT_PATH}

# set locale attrib
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install locales && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

# toolchain install
RUN apt-get update && apt-get -y --no-install-recommends install \
	apt-transport-https ca-certificates \
	bison \
	build-essential \
	procps \
	curl \
	flex \
	git \
	gnat \
	libncurses5-dev \
	m4 \
	zlib1g-dev \
        iproute2 \
        jq \
        python3 \
        python-is-python3 \
        qemu-system-x86 \
        udhcpd \
        mc && \
	apt-get clean

# prepare coreboot framework
WORKDIR ${GRUB2_PATH}
	
RUN git clone git://git.savannah.gnu.org/grub.git grub && \
	cd grub/ && \
	git checkout grub-2.06
	
RUN apt-get update && apt-get -y --no-install-recommends install \
	autoconf \
	autogen automake \
	autopoint \
	bison \
	build-essential \
	flex \
	help2man \
	libdevmapper-dev \
	libfreetype6-dev \
	libfuse-dev \
	liblzma-dev \
	libpci-dev \
	libssl-dev \
	m4 \
	fonts-dejavu\
	fonts-unifont \
	zlib1g-dev && \
	apt-get clean	
	
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bash_profile && \
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
	brew install gettext && brew link gettext --force 
#	cd ${GRUB2_PATH}/grub && \
#	./bootstrap && \
#	./configure --with-platform=coreboot
#	make

# Change workdir
WORKDIR [${GRUB2_PATH}]
FROM ubuntu:trusty
MAINTAINER Chris Hardekopf <cjh@ygdrasill.com>

# Don't install recommended or suggested packages
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends && \
    echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends

ENV BUILD_PACKAGES=" \
        gcc \
        python3-dev \
        python3-pip \
        libssl-dev \
        libacl1-dev \
        openssh-client \
        pkg-config \
        libfuse-dev" \
    RUNTIME_PACKAGES=" \
        python3 \
        sshfs" \
    DEBIAN_FRONTEND=noninteractive

ADD requirements.txt /opt/

# Install packages required
RUN apt-get update && \
    apt-get install -y $RUNTIME_PACKAGES $BUILD_PACKAGES && \
    # Install the python requirements \
    pip3 install --upgrade --requirement /opt/requirements.txt && \
    # Install attic \
    pip3 install attic && \
    # Clean up unused packages \
    apt-get purge -y $BUILD_PACKAGES `apt-mark showauto` && \
    apt-get install -y $RUNTIME_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

# Add the start script
ADD start /opt/

# Set the ENTRYPOINT
ENTRYPOINT [ "/opt/start" ]
##CMD [ "/opt/start" ]

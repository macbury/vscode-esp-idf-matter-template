FROM --platform=linux/amd64 espressif/idf:release-v4.4
ENV IDF_CCACHE_ENABLE=1
ENV DEBIAN_FRONTEND=noninteractive

ARG DEBIAN_FRONTEND=nointeractive
ARG CONTAINER_USER=esp
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y -q \
  cmake \
  git \
  hwdata \
  libglib2.0-0 \
  libnuma1 \
  libpixman-1-0 \
  linux-tools-virtual

RUN apt-get install -y git gcc g++ pkg-config libssl-dev libdbus-1-dev \
  libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev \
  python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev libusb-1.0-0-dev cmake

RUN update-alternatives --install /usr/local/bin/usbip usbip `ls /usr/lib/linux-tools/*/usbip | tail -n1` 20

COPY scripts/build.sh /tmp/build.sh
RUN bash /tmp/build.sh

# RUN cd /opt/esp/idf && \
#   . ./export.sh && \
#   cd .. && \
#   git clone --depth 1 https://github.com/espressif/esp-matter.git && \
#   cd esp-matter && \
#   git submodule update --init --depth 1 && \
#   cd ./connectedhomeip/connectedhomeip && \
#   ./scripts/checkout_submodules.py --platform esp32 linux --shallow && \
#   cd ../.. && \
#   ./install.sh && \
#   cd ..

# https://docs.espressif.com/projects/esp-matter/en/latest/esp32/developing.html#configuring-the-environment

# QEMU
ENV QEMU_REL=esp-develop-20220919
ENV QEMU_SHA256=f6565d3f0d1e463a63a7f81aec94cce62df662bd42fc7606de4b4418ed55f870
ENV QEMU_DIST=qemu-${QEMU_REL}.tar.bz2
ENV QEMU_URL=https://github.com/espressif/qemu/releases/download/${QEMU_REL}/${QEMU_DIST}

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN wget --no-verbose ${QEMU_URL} \
  && echo "${QEMU_SHA256} *${QEMU_DIST}" | sha256sum --check --strict - \
  && tar -xf $QEMU_DIST -C /opt \
  && rm ${QEMU_DIST}

ENV PATH=/opt/qemu/bin:${PATH}

COPY entrypoint.sh /opt/esp/entrypoint.sh
RUN chmod +x /opt/esp/entrypoint.sh

# RUN groupadd --gid $USER_GID $CONTAINER_USER \
#     && adduser --uid $USER_UID --gid $USER_GID --disabled-password --gecos "" ${CONTAINER_USER} \
#     && usermod -a -G dialout $CONTAINER_USER

# USER ${CONTAINER_USER}
# ENV USER=${CONTAINER_USER}
WORKDIR /root

RUN echo "source /opt/esp/idf/export.sh > /dev/null 2>&1" >> ~/.bashrc
RUN echo "source /opt/esp/esp-matter/export.sh > /dev/null 2>&1" >> ~/.bashrc
RUN echo "export IDF_CCACHE_ENABLE=1" >> ~/.bashrc

ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]

CMD ["/bin/bash", "-c"]

FROM nvidia/cuda:11.1-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt install -y git build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev pkg-config

RUN apt-get install -y libcurl4-gnutls-dev librtmp-dev apt-transport-https ca-certificates
RUN update-ca-certificates

RUN git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git && \
    cd nv-codec-headers && \
    git checkout origin/sdk/10.0 && \
    make install && \
    cd ..

RUN git clone https://github.com/FFmpeg/FFmpeg ffmpeg && \
    cd ffmpeg && \
    ./configure --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 && \
    make -j $nrpoc && make install

WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/ffmpeg"]
CMD ["-h"]

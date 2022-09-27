FROM rust:1.64

WORKDIR /opt/osxcross
RUN apt update && apt dist-upgrade -y
RUN apt install -y wget git clang cmake libssl-dev libz-dev
RUN rustup target add x86_64-apple-darwin
RUN git clone https://github.com/tpoechtrager/osxcross .
RUN wget -nc https://s3.dockerproject.org/darwin/v2/MacOSX10.10.sdk.tar.xz
RUN mv MacOSX10.10.sdk.tar.xz tarballs/
RUN UNATTENDED=yes OSX_VERSION_MIN=10.7 TARGET_DIR=/opt/osxcross/cross-compiler ./build.sh
RUN echo "[target.x86_64-apple-darwin]" >> $CARGO_HOME/config.toml
RUN echo 'linker = "/opt/osxcross/cross-compiler/bin/x86_64-apple-darwin14-cc"' >> $CARGO_HOME/config.toml
RUN export PATH="/opt/osxcross/cross-compiler/bin:$PATH"
ENV C_INCLUDE_PATH=/opt/osxcross/cross-compiler/SDK/MACOSX10.10.sdk/usr/include
ENV TARGET_CC=/opt/osxcross/cross-compiler/bin/x86_64-apple-darwin14-cc
WORKDIR /app

CMD ["cargo", "build"]

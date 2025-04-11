FROM ubuntu:22.04
LABEL \
    org.opencontainers.image.title="OpenNebula 6.10" \
    org.opencontainers.image.vendor="Ubuntu22 build system" \
    org.opencontainers.image.licenses="Apache" \
    org.opencontainers.image.created="2025-04-09" \
    maintainer="slackman.cn"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LANG=en_US.UTF8 \
    LC_ALL=en_US.UTF8 \
    LANGUAGE=enUS:en \
    PATH="/usr/local/ruby/bin:/usr/local/ruby-build/bin:/usr/local/go/bin:/usr/local/node/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime  \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata 


# Install build base
WORKDIR /build
COPY . ./

RUN bash build-system.sh && bash clone-source.sh \
  && apt-get clean && rm -rf /var/lib/apt/lists/*


CMD ["bash"]

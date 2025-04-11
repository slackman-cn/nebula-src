#!/bin/bash
#
# Ubuntu22 build system @202504

set -ex

GOLANG_TAG="linux-amd64"
NODE_TAG="linux-x64"
RUBY_BUILD="v20250409"
RUBY_TAG="3.3.8"

# Install Base dependencies (curl include ca-certificates)
apt-get install --no-install-recommends --yes language-pack-en 
apt-get install --yes build-essential vim less git wget curl 
# Install OpenNebula dependencies 
apt-get install --yes  bash-completion freerdp2-dev  libaugeas-dev libcairo2-dev libcurl4-openssl-dev  libnode-dev libossp-uuid-dev libpango1.0-dev libpulse-dev  libssh2-1-dev libssl-dev \
    libsystemd-dev libtool libvncserver-dev libvorbis-dev libwebp-dev libws-commons-util-java libxml2-dev libxmlrpc-c++8-dev libxslt1-dev libzmq3-dev libzmq5 \
    libsqlite3-dev libmysql++-dev libmysqlclient-dev \
    python3 python3-pip python3-setuptools scons unzip \
    pkgconf 


# Install Go
curl -sL "https://go.dev/dl/go1.24.2.${GOLANG_TAG}.tar.gz" | tar -C /usr/local/ -zx
go version

# Install Node
mkdir /usr/local/node/
curl -sL "https://nodejs.org/dist/v22.11.0/node-v22.11.0-${NODE_TAG}.tar.xz" | tar -C /usr/local/node/ -Jx --strip-components=1

# Install Ruby
apt-get install --yes \
   autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
git clone https://github.com/rbenv/ruby-build.git /build/ruby-build  --depth 1 -b "${RUBY_BUILD}"
PREFIX=/usr/local/ruby-build ./ruby-build/install.sh
ruby-build --list  
ruby-build ${RUBY_TAG} /usr/local/ruby


# Install RubyGems
cd deps
bundle install
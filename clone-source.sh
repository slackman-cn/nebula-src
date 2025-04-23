#!/bin/bash
#
# OpenNebula source code @202504

set -ex

# Configure git
git config --global user.email "slackman@disroot.org"
git config --global user.name "slackman"
git config --global --add advice.detachedHead false
git config --global core.autocrlf false

# OpenNebula projects
ONE_TAG="release-6.10.2"
MINIONE_TAG="v6.10.3"
# Container projects
SKOPEO_TAG="v1.18.0"
UMOCI_TAG="v0.4.7"
# QEMU projects
QEMU_TAG="v9.2.3"
EDK2_TAG="edk2-stable202411"
SEABIOS_TAG="rel-1.16.3"
SWTPM_TAG="v0.10.0"
LIBTPMS_TAG="v0.10.0"
NASM_TAG="nasm-2.16.03"


git clone https://github.com/OpenNebula/one.git  /build/one --depth 1 -b "${ONE_TAG}"
git clone https://github.com/OpenNebula/minione.git  /build/minione --depth 1 -b "${MINIONE_TAG}"
git clone https://github.com/OpenNebula/marketplace.git  /build/marketplace --depth 1 
git clone https://github.com/OpenNebula/marketplace-community.git  /build/marketplace-community --depth 1 

git clone https://github.com/containers/skopeo /build/skopeo --depth 1 -b "${SKOPEO_TAG}"
git clone https://github.com/opencontainers/umoci /build/umoci --depth 1 -b "${UMOCI_TAG}"

git clone https://gitlab.com/qemu-project/qemu /build/qemu --depth 1 -b "${QEMU_TAG}"
git clone https://github.com/tianocore/edk2 /build/edk2 --recurse-submodules --shallow-submodules --depth 1 -b "${EDK2_TAG}"
git clone https://gitlab.com/qemu-project/seabios /build/seabios --depth 1 -b "${SEABIOS_TAG}"
git clone https://github.com/stefanberger/libtpms /build/libtpms --depth 1 -b "${LIBTPMS_TAG}"
git clone https://github.com/stefanberger/swtpm /build/swtpm --depth 1 -b "${SWTPM_TAG}"

mkdir /build/nasm/
# www.nasm.us is down @202504
#curl -sL "https://www.nasm.us/pub/nasm/releasebuilds/$(echo ${NASM_TAG} | cut -d- -f2)/${NASM_TAG}.tar.gz" | tar -C /build/nasm/ -zx --strip-components=1

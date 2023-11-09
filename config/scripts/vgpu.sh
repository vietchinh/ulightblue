#!/bin/sh

set -oeux pipefail

cd /tmp

### BUILD nvidia

NVIDIA_VERSION="535.104"
ZIP_NAME="NVIDIA-GRID-Linux-KVM-${NVIDIA_VERSION}.06-535.104.05-537.13.zip"
KERNEL_VERSION="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
DEVELOPMENT_PACKAGES="wget p7zip p7zip-plugins mscompress osslsigncode git kernel-devel-${KERNEL_VERSION} unzip patch vulkan-loader akmods"

rpm-ostree install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" "https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-$(rpm -E %fedora)-1.noarch.rpm"
# shellcheck disable=SC2086
rpm-ostree install ${DEVELOPMENT_PACKAGES} vulkan-loader

git clone --recursive https://github.com/VGPU-Community-Drivers/vGPU-Unlock-patcher.git -b ${NVIDIA_VERSION}

VGPU_FOLDER="vGPU-Unlock-patcher"

wget -q "https://github.com/justin-himself/NVIDIA-VGPU-Driver-Archive/releases/download/16.1/${ZIP_NAME}"
unzip ${ZIP_NAME} -d ${VGPU_FOLDER}
rm -f ${ZIP_NAME}

cd ${VGPU_FOLDER}

mv Guest_Drivers/* .
mv Host_Drivers/* .
mv Signing_Keys/* .

chmod +x patch.sh

./patch.sh general-merge

./NVIDIA-Linux-x86_64-535.104.05-merged-vgpu-kvm-patched/nvidia-installer -s --kernel-source-path /usr/src/kernels/"${KERNEL_VERSION}" --no-systemd --no-dkms
akmods --force --kernels "${KERNEL_VERSION}" --kmod "nvidia"

cd ..
rm -rf ${VGPU_FOLDER}
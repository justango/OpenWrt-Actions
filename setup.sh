#!/bin/bash
# Copyright (C) 2021 Ango <m@ango.me>

# Clone OpenWrt
OP_REPO_URL=https://github.com/openwrt/openwrt
OP_REPO_BRANCH=master
cd $GITHUB_WORKSPACE/openwrt
git clone $OP_REPO_URL -b $OP_REPO_BRANCH

# Clone Package
cd $GITHUB_WORKSPACE/openwrt/package
# git clone https://git.example.com

# Update & Install feeds
cd $GITHUB_WORKSPACE/openwrt/scripts
./feeds update -a && ./feeds install -a

# Generate Config
cd $GITHUB_WORKSPACE/openwrt
rm -f ./.config* && touch ./.config
cat >> ./.config <<EOF
# ======== Custom Config ========

CONFIG_TARGET_rockchip=y
CONFIG_TARGET_rockchip_armv8=y
CONFIG_TARGET_rockchip_armv8_DEVICE_friendlyarm_nanopi-r2s=y
CONFIG_TARGET_ROOTFS_PARTSIZE=1024
CONFIG_KERNEL_BUILD_DOMAIN="Actions"
CONFIG_KERNEL_BUILD_USER="Ango"

CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_drill=y

CONFIG_PACKAGE_luci-app-https-dns-proxy=y
# CONFIG_PACKAGE_dnsmasq is not set
CONFIG_PACKAGE_dnsmasq-full=y

CONFIG_PACKAGE_luci-app-simple-adblock=y
CONFIG_PACKAGE_luci-app-sqm=y
CONFIG_PACKAGE_luci-app-wol=y

CONFIG_PACKAGE_luci-app-dockerman=y
CONFIG_DOCKER_KERNEL_OPTIONS=y
CONFIG_DOCKER_NET_ENCRYPT=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_DOCKER_NET_OVERLAY=y
CONFIG_DOCKER_NET_TFTP=y
CONFIG_DOCKER_RES_SHAPE=y
CONFIG_DOCKER_SECCOMP=y
CONFIG_DOCKER_STO_BTRFS=y
CONFIG_DOCKER_STO_EXT4=y

CONFIG_PACKAGE_cgi-io=y
CONFIG_PACKAGE_libiwinfo=y
CONFIG_PACKAGE_libiwinfo-lua=y
CONFIG_PACKAGE_liblua=y
CONFIG_PACKAGE_liblucihttp=y
CONFIG_PACKAGE_liblucihttp-lua=y
CONFIG_PACKAGE_libubus-lua=y
CONFIG_PACKAGE_lua=y
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-app-firewall=y
CONFIG_PACKAGE_luci-app-opkg=y
CONFIG_PACKAGE_luci-base=y
CONFIG_PACKAGE_luci-lib-base=y
CONFIG_PACKAGE_luci-lib-ip=y
CONFIG_PACKAGE_luci-lib-jsonc=y
CONFIG_PACKAGE_luci-lib-nixio=y
CONFIG_PACKAGE_luci-mod-admin-full=y
CONFIG_PACKAGE_luci-mod-network=y
CONFIG_PACKAGE_luci-mod-status=y
CONFIG_PACKAGE_luci-mod-system=y
CONFIG_PACKAGE_luci-proto-ipv6=y
CONFIG_PACKAGE_luci-proto-ppp=y
CONFIG_PACKAGE_luci-ssl=y
CONFIG_PACKAGE_luci-theme-bootstrap=y
CONFIG_PACKAGE_px5g-wolfssl=y
CONFIG_PACKAGE_rpcd=y
CONFIG_PACKAGE_rpcd-mod-file=y
CONFIG_PACKAGE_rpcd-mod-iwinfo=y
CONFIG_PACKAGE_rpcd-mod-luci=y
CONFIG_PACKAGE_rpcd-mod-rrdns=y
CONFIG_PACKAGE_uhttpd=y
CONFIG_PACKAGE_uhttpd-mod-ubus=y

# ===============================
EOF
sed -i 's/^[ \t]*//g' ./.config

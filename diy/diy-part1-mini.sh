
#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default
#echo 'src-git turboacc https://github.com/chenmozhijin/turboacc' >> feeds.conf.default
echo 'src-git theme https://github.com/zijieKwok/istoreos-theme' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default

#mkdir -p files/etc/openclash/core
#wget -qO- https://raw.githubusercontent.com/vernesong/OpenClash/refs/heads/core/dev/meta/clash-linux-arm64.tar.gz | tar xOvz > files/etc/openclash/core/clash_meta
#chmod +x files/etc/openclash/core/clash_meta
#wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat > files/etc/openclash/GeoIP.dat
#wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat > files/etc/openclash/GeoSite.dat

mkdir -p files/etc/config
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/openclash > files/etc/config/openclash
#wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/smartdns > files/etc/config/smartdns

mkdir -p files/etc/opkg
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf
mkdir -p files/root
wget -qO- https://raw.githubusercontent.com/sos801107/TP-Link-TL-XDR6086/refs/heads/main/etc/.profile > files/root/.profile
#luci openwrt-24.10
#sed -i 's/coolsnowwolf\/luci/openwet\/luci/g' ./feeds.conf.default
#sed -i 's/openwrt-23.05/openwrt-24.10/g' ./feeds.conf.default

#!/bin/bash
mkdir -p files/etc/config
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/openclash > files/etc/config/openclash
#wget -qO- https://raw.githubusercontent.com/liandu2024/clash/refs/heads/main/main_router/openclash > files/etc/config/openclash
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/smartdns > files/etc/config/smartdns

mkdir -p files/etc
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/opkg.conf > files/etc/opkg.conf
mkdir -p files/etc/opkg
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/x86/distfeeds.conf > files/etc/opkg/distfeeds.conf-86
mkdir -p files/root
wget -qO- https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/etc/.profile > files/root/.profile
# 修改默认IP
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.1.1/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='iStoreOS'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate
# TTYD
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# sed -i '3 a\\t\t"order": 50,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# sed -i 's/procd_set_param stdout 1/procd_set_param stdout 0/g' feeds/packages/utils/ttyd/files/ttyd.init
# sed -i 's/procd_set_param stderr 1/procd_set_param stderr 0/g' feeds/packages/utils/ttyd/files/ttyd.init

# 修改默认密码
#sed -i 's/root:::0:99999:7:::/root:$1$5mjCdAB1$Uk1sNbwoqfHxUmzRIeuZK1:0:0:99999:7:::/g' package/base-files/files/etc/shadow
#rm -rf include/version.mk
#cp -af feeds/istoreos_ipk/patch/istoreos-24.10/version.mk include

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

# default-settings
git clone --depth=1 -b openwrt-24.10 https://github.com/Jaykwok2999/default-settings package/default-settings

# mwan3
sed -i 's/MultiWAN 管理器/负载均衡/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

# samba4
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

# linkease调至NAS
sed -i 's/services/nas/g' feeds/nas-packages-luci/luci/luci-app-linkease/luasrc/controller/linkease.lua
sed -i 's/services/nas/g' feeds/nas-packages-luci/luci/luci-app-linkease/luasrc/view/linkease_status.htm

# HD磁盘工具调至NAS
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json

# 修改FileBrowser
sed -i 's/msgstr "FileBrowser"/msgstr "文件浏览器"/g' feeds/istoreos_ipk/op-fileBrowser/luci-app-filebrowser/po/zh_Hans/filebrowser.po
sed -i 's/services/nas/g' feeds/istoreos_ipk/op-fileBrowser/luci-app-filebrowser/root/usr/share/luci/menu.d/luci-app-filebrowser.json

# 修改socat为端口转发
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/third_party/luci-app-socat/po/zh-cn/socat.po

##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='iStoreOS-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By sos07'/g" package/base-files/files/etc/openwrt_release

# 移除要替换的包
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,adguardhome}
rm -rf feeds/packages/net/alist feeds/luci/applications/luci-app-alist
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/third_party/luci-app-LingTiGameAcc
rm -rf feeds/istoreos_ipk/op-daed
rm -rf feeds/third/luci-theme-argon
rm -rf feeds/istoreos_ipk/patch/istoreos-24.10/istoreos-files
rm -rf feeds/small/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/applications/{shadowsocksr-libev,shadowsocks-rust,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-ssr-plus,luci-i18n-ssr-plus-zh-cn,luci-app-wol,luci-app-bypass,luci-app-argon-config,luci-theme-argon}
rm -rf feeds/luci/packages/net/{shadowsocksr-libev-ssr-check,shadowsocksr-libev-ssr-local,shadowsocksr-libev-ssr-redir,shadowsocksr-libev-ssr-server}
# 将packages源的相关文件替换成passwall_packages源的
rm -rf feeds/istoreos_ipk/patch/wall-luci/luci-app-passwall
rm -rf feeds/istoreos_ipk/geoview
rm -rf feeds/third_party/luci-app-smartdns
rm -rf feeds/third_party/smartdns
rm -rf feeds/istoreos_ipk/op-mosdns
rm -rf feeds/istoreos_ipk/xray-core
rm -rf feeds/istoreos_ipk/sing-box
rm -rf feeds/istoreos_ipk/chinadns-ng
rm -rf feeds/istoreos_ipk/microsocks
rm -rf feeds/istoreos_ipk/dns2socks
rm -rf feeds/istoreos_ipk/ipt2socks
rm -rf feeds/istoreos_ipk/patch/istoreos-24.10
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-geoip
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/dns2tcp
rm -rf feeds/packages/net/microsocks
cp -r feeds/small/xray-core feeds/packages/net
cp -r feeds/small/mosdns feeds/packages/net
cp -r feeds/small/v2ray-geodata feeds/packages/net
cp -r feeds/small/v2ray-geoip feeds/packages/net
cp -r feeds/small/sing-box feeds/packages/net
cp -r feeds/small/chinadns-ng feeds/packages/net
cp -r feeds/small/dns2socks feeds/packages/net
cp -r feeds/small/ipt2socks feeds/packages/net
cp -r feeds/small/microsocks feeds/packages/net
cp -r feeds/small/geoview feeds/packages/net



# istoreos-theme
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/third/luci-theme-argon
rm -rf feeds/istoreos_ipk/theme/luci-theme-argon
#cp -r feeds/theme/luci-theme-argon feeds/luci/themes/luci-theme-argon
rm -rf feeds/third/luci-app-argon-config
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/istoreos_ipk/theme/luci-app-argon-config
#cp -r feeds/theme/luci-app-argon-config feeds/luci/applications/luci-app-argon-config

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
        echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}


git_sparse_clone main https://github.com/Jaykwok2999/istoreos-theme luci-theme-argon
git_sparse_clone main https://github.com/Jaykwok2999/istoreos-theme luci-app-argon-config



# golong1.24.2依赖
rm -rf feeds/packages/lang/golang
# git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
# git clone https://git.kejizero.online/zhao/packages_lang_golang -b 23.x feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

# SSRP & Passwall
git clone https://git.kejizero.online/zhao/openwrt_helloworld.git package/helloworld -b v5
rm -rf package/helloworld/luci-app-openclash

# Alist
git clone https://git.kejizero.online/zhao/luci-app-alist package/alist

# Mosdns
git clone https://git.kejizero.online/zhao/luci-app-mosdns.git -b v5 package/mosdns
git clone https://git.kejizero.online/zhao/v2ray-geodata.git package/v2ray-geodata

# 锐捷认证
# git clone https://github.com/sbwml/luci-app-mentohust package/mentohust

# Adguardhome
# git_sparse_clone master https://github.com/kenzok8/openwrt-packages adguardhome luci-app-adguardhome

# default-settings
# git clone --depth=1 -b dev https://github.com/Jaykwok2999/default-settings package/default-settings

# UPnP
rm -rf feeds/{packages/net/miniupnpd,luci/applications/luci-app-upnp}
git clone https://git.kejizero.online/zhao/miniupnpd feeds/packages/net/miniupnpd -b v2.3.7
git clone https://git.kejizero.online/zhao/luci-app-upnp feeds/luci/applications/luci-app-upnp -b master

# Lucky
# git clone https://github.com/gdy666/luci-app-lucky.git package/lucky

# luci-app-webdav
# git clone https://git.kejizero.online/zhao/luci-app-webdav package/new/luci-app-webdav

# unzip
rm -rf feeds/packages/utils/unzip
git clone https://github.com/sbwml/feeds_packages_utils_unzip feeds/packages/utils/unzip

# frpc名称
sed -i 's,发送,Transmission,g' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po
sed -i 's,frp 服务器,frps 服务器,g' feeds/luci/applications/luci-app-frps/po/zh_Hans/frps.po
sed -i 's,frp 客户端,frpc 客户端,g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

# 必要的补丁
pushd feeds/luci
   curl -s https://raw.githubusercontent.com/oppen321/path/refs/heads/main/Firewall/0001-luci-mod-status-firewall-disable-legacy-firewall-rul.patch | patch -p1
popd

# NTP
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/ntp2.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/time2.cloud.tencent.com/g' package/base-files/files/bin/config_generate

# 更改 banner
#rm -rf package/base-files/files/etc/banner
#cp -af feeds/istoreos_ipk/patch/diy/banner package/base-files/files/etc/

# tailscale
rm -rf feeds/packages/net/tailscale
# rm -rf feeds/istoreos_ipk/tailscale/tailscale
# cp -af feeds/istoreos_ipk/tailscale/tailscale  feeds/packages/net/
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

# 增加驱动补丁
# cp -af feeds/istoreos_ipk/patch/diy/patches-6.6/993-bnx2x_warpcore_8727_2_5g_sgmii_txfault.patch target/linux/x86/patches-6.6/
cp -af feeds/istoreos_ipk/patch/diy/patches-6.6/996-intel-igc-i225-i226-disable-eee.patch target/linux/x86/patches-6.6/

./scripts/feeds update -a
./scripts/feeds install -a

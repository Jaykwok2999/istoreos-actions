#!/bin/bash

mkdir -p files/etc/config
#wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-ipk/refs/heads/main/patch/diy/openclash > files/etc/config/openclash
#wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-ipk/refs/heads/main/patch/diy/proxy/openclash > files/etc/config/openclash
#wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-ipk/refs/heads/main/patch/diy/mosdns > files/etc/config/mosdns
wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-ipk/refs/heads/main/patch/diy/smartdns > files/etc/config/smartdns

mkdir -p files/etc
wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-actions/refs/heads/main/etc/opkg.conf > files/etc/opkg.conf
mkdir -p files/etc/opkg
wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-actions/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf-86
wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-actions/refs/heads/main/etc/distfeeds.conf > files/etc/opkg/distfeeds.conf

# mkdir -p files/root
wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-actions/refs/heads/main/etc/.profile > files/root/.profile

# 更改时间戳
rm -rf scripts/get_source_date_epoch.sh
mkdir -p scripts
wget -qO- https://raw.githubusercontent.com/Jaykwok2999/istoreos-actions/refs/heads/main/patch/get_source_date_epoch.sh > scripts/get_source_date_epoch.sh
chmod +x scripts/get_source_date_epoch.sh

# 更改 banner
rm -rf package/base-files/files/etc/banner
cp -af feeds/istoreos_ipk/patch/istoreos-24.10/banner package/base-files/files/etc/

##加入作者信息
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By JayKwok'/g" package/base-files/files/etc/openwrt_release

# 修改默认IP
sed -i 's/192.168.100.1/192.168.2.1/g' package/istoreos-files/Makefile
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改默认密码
sed -i 's/root:::0:99999:7:::/root:$1$5mjCdAB1$Uk1sNbwoqfHxUmzRIeuZK1:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# TTYD
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json

# iStoreOS-settings
git clone --depth=1 -b main https://github.com/Jaykwok2999/istoreos-settings package/default-settings

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

# mwan3
sed -i 's/MultiWAN 管理器/负载均衡/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

# samba4与ksmbd网络共享NAS
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-ksmbd/root/usr/share/luci/menu.d/luci-app-ksmbd.json

# minidlna调至NAS
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json

# Alist调至NAS
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
#sed -i 's/msgstr "AList"/msgstr "AList文件列表"/g' feeds/luci/applications/luci-app-alist/po/zh_Hans/alist.po
#sed -i 's/msgstr "AList"/msgstr "AList文件列表"/g' feeds/luci/applications/luci-app-alist/po/zh_Hant/alist.po

# HD磁盘工具调至NAS
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json

# 修改FileBrowser
sed -i 's/msgstr "FileBrowser"/msgstr "文件浏览器"/g' feeds/istoreos_ipk/op-fileBrowser/luci-app-filebrowser/po/zh_Hans/filebrowser.po
sed -i 's/services/nas/g' feeds/istoreos_ipk/op-fileBrowser/luci-app-filebrowser/root/usr/share/luci/menu.d/luci-app-filebrowser.json

# 修改socat
sed -i 's/msgid "Socat"/msgid "端口转发"/g' feeds/third_party/luci-app-socat/po/zh-cn/socat.po
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/third_party/luci-app-socat/po/zh-cn/socat.po

# 移除要替换的包
rm -rf feeds/packages/net/{adguardhome,miniupnpd}
# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/istoreos_ipk/caddy
rm -rf feeds/istoreos_ipk/luci-app-caddy
# rm -rf feeds/packages/net/alist feeds/luci/applications/luci-app-alist
rm -rf feeds/luci/applications/luci-app-upnp
# rm -rf feeds/luci/applications/smartdns
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/third_party/luci-app-LingTiGameAcc
# rm -rf feeds/third_party/luci-app-socat
rm -rf feeds/istoreos_ipk/op-daed
rm -rf feeds/istoreos_ipk/patch/istoreos-files
rm -rf feeds/istoreos_ipk/vlmcsd
rm -rf feeds/istoreos_ipk/patch/wall-luci/luci-app-vlmcsd
rm -rf package/diy/luci-app-ota
rm -rf feeds/istoreos_ipk/tailscale
#rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/luci/applications/luci-app-docker
#rm -rf feeds/istoreos_ipk/luci-lib-docker

# istoreos-theme
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/third/luci-theme-argon
rm -rf feeds/third/luci-app-argon-config
rm -rf feeds/istoreos_ipk/theme/luci-theme-argon


echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"魔法网络\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

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


git_sparse_clone main https://github.com/Jaykwok2999/istoreos-theme luci-app-argon-config
git_sparse_clone main https://github.com/Jaykwok2999/istoreos-ota luci-app-ota
git_sparse_clone main https://github.com/zijieKwok/github-ota fw_download_tool
#git_sparse_clone main https://github.com/kiddin9/op-packages luci-app-dockerman
#git_sparse_clone main https://github.com/kiddin9/op-packages luci-app-docker
git_sparse_clone main https://github.com/kiddin9/op-packages luci-app-upnp
git_sparse_clone main https://github.com/kiddin9/op-packages miniupnpd
git_sparse_clone dev https://github.com/vernesong/OpenClash luci-app-openclash
# git clone https://github.com/Jaykwok2999/passwall-packages.git package/passwall_packages
# git clone https://github.com/pymumu/luci-app-smartdns.git luci-app-smartdns
# git clone https://github.com/pymumu/openwrt-smartdns.git smartdns


# SSRP & Passwall
git_sparse_clone main https://github.com/kiddin9/op-packages luci-app-passwall
cp -af feeds/istoreos_ipk/patch/un.svg package/luci-app-passwall/root/www/luci-static/passwall/flags/

# samba4
#rm -rf feeds/packages/libs/liburing
#git clone https://github.com/sbwml/feeds_packages_libs_liburing feeds/packages/libs/liburing
rm -rf feeds/packages/net/samba4
git clone https://github.com/sbwml/feeds_packages_net_samba4 feeds/packages/net/samba4

# golong26.x依赖
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

rm -rf package/feeds/packages/rust
git_sparse_clone openwrt-24.10 https://github.com/immortalwrt/packages lang/rust

# upnp调至NAS
sed -i 's/services/nas/g' package/luci-app-upnp/root/usr/share/luci/menu.d/luci-app-upnp.json

# unzip
# rm -rf feeds/packages/utils/unzip
# git clone https://github.com/sbwml/feeds_packages_utils_unzip feeds/packages/utils/unzip

# frpc名称
sed -i 's,发送,Transmission,g' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po
sed -i 's,frp 服务器,frps 服务器,g' feeds/luci/applications/luci-app-frps/po/zh_Hans/frps.po
sed -i 's,frp 客户端,frpc 客户端,g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

# tailscale
#rm -rf feeds/packages/net/tailscale
#sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

# 必要的补丁
#pushd feeds/luci
#  curl -sSL https://raw.githubusercontent.com/Jaykwok2999/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
#popd

./scripts/feeds update -a
./scripts/feeds install -a

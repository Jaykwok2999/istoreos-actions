#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
echo 'src-git istoreos_ipk https://github.com/Jaykwok2999/istoreos-ipk' >> feeds.conf.default
# Add feed sources
# echo 'src-git store https://github.com/linkease/istore' >>feeds.conf.default

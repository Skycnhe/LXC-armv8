#!/bin/bash

# 1. 允许 Root SSH 登录 (OpenWrt 24.x 默认禁止)
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' package/network/services/dropbear/files/dropbear.config

# 2. 移除默认 Root 密码 (空密码)
sed -i 's/root:::0:99999:7:::/root:$1$0$0:0:99999:7:::/g' package/base-files/files/etc/shadow

# 3. 修改主机名
sed -i 's/OpenWrt/OpenWrt-LXC/g' package/base-files/files/bin/config_generate

# 4. 修复 rc.local 可执行权限 (LXC 环境有时需要)
chmod +x package/base-files/files/etc/rc.local

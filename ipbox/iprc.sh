#!/bin/bash

# 网卡名称，根据实际情况替换eth0为您的网卡名称
network_interface="eth0"

# 存储上一次的IP地址
last_ipv4_file="/ipbox/last_ipv4.txt"
last_ipv6_file="/ipbox/last_ipv6.txt"

# 获取当前的IPv4和IPv6地址
current_ipv4=$(ip -4 addr show $network_interface | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
current_ipv6=$(ip -6 addr show $network_interface | grep "inet6\b" | awk '{print $2}' | cut -d/ -f1)

# 检查上一次的IPv4地址是否存在
if [ -f "$last_ipv4_file" ]; then
    last_ipv4=$(cat "$last_ipv4_file")
else
    echo "IPv4: 首次运行，或/ipbox/last_ipv4.txt被删除。"
    last_ipv4=""
fi

# 检查上一次的IPv6地址是否存在
if [ -f "$last_ipv6_file" ]; then
    last_ipv6=$(cat "$last_ipv6_file")
else
    echo "IPv6: 首次运行，或/ipbox/last_ipv6.txt被删除。"
    last_ipv6=""
fi

# 比较当前IPv4和上一次的IPv4
ipv4_changed=false
if [ "$current_ipv4" != "$last_ipv4" ]; then
    echo "IPv4地址发生变化：从 $last_ipv4 变更为 $current_ipv4"
    echo "$current_ipv4" > "$last_ipv4_file"
    ipv4_changed=true
else
    echo "IPv4地址未发生变化：$current_ipv4"
fi

# 比较当前IPv6和上一次的IPv6
ipv6_changed=false
if [ "$current_ipv6" != "$last_ipv6" ]; then
    echo "IPv6地址发生变化：从 $last_ipv6 变更为 $current_ipv6"
    echo "$current_ipv6" > "$last_ipv6_file"
    ipv6_changed=true
else
    echo "IPv6地址未发生变化：$current_ipv6"
fi

# 如果任一IP地址发生变化，则重启系统
if $ipv4_changed || $ipv6_changed; then
    echo "由于IP地址变化，系统即将重启..."
    /sbin/shutdown -r now "IP地址变化，正在重启系统。"
fi
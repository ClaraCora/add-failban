#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=================================="
echo "    fail2ban 配置测试脚本"
echo "=================================="
echo

# 检查fail2ban是否安装
if command -v fail2ban-client &> /dev/null; then
    echo -e "${GREEN}✓${NC} fail2ban 已安装"
else
    echo -e "${RED}✗${NC} fail2ban 未安装"
    exit 1
fi

# 检查服务状态
if sudo systemctl is-active --quiet fail2ban; then
    echo -e "${GREEN}✓${NC} fail2ban 服务正在运行"
else
    echo -e "${RED}✗${NC} fail2ban 服务未运行"
fi

# 检查SSH监狱状态
if sudo fail2ban-client status sshd &> /dev/null; then
    echo -e "${GREEN}✓${NC} SSH 监狱已启用"
    echo "SSH 监狱状态："
    sudo fail2ban-client status sshd
else
    echo -e "${YELLOW}⚠${NC} SSH 监狱可能未正确配置"
fi

# 检查配置文件
if [ -f "/etc/fail2ban/jail.d/sshd.local" ]; then
    echo -e "${GREEN}✓${NC} 配置文件存在"
    echo "配置文件内容："
    cat /etc/fail2ban/jail.d/sshd.local
else
    echo -e "${RED}✗${NC} 配置文件不存在"
fi

echo
echo "测试完成！" 
#!/bin/bash

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否为root用户
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_warn "检测到root用户运行，脚本将继续执行"
    else
        log_info "使用普通用户运行，脚本将使用sudo权限"
    fi
}

# 检测系统类型
detect_system() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        OS=SuSE
    elif [ -f /etc/redhat-release ]; then
        OS=RedHat
    else
        OS=$(uname -s)
        VER=$(uname -r)
    fi
    log_info "检测到系统: $OS $VER"
}

# 安装fail2ban
install_fail2ban() {
    log_info "正在安装 fail2ban..."
    
    if [ -x "$(command -v apt)" ]; then
        log_info "使用 apt 包管理器"
        
        # 设置环境变量以自动处理交互式提示
        export DEBIAN_FRONTEND=noninteractive
        export DEBCONF_NONINTERACTIVE_SEEN=true
        
        if [[ $EUID -eq 0 ]]; then
            # 使用 -y 和 -q 参数，并设置环境变量
            apt update -y -q
            # 预设所有可能的交互式配置
            {
                echo "fail2ban fail2ban/banaction select iptables-multiport"
                echo "fail2ban fail2ban/banaction_ssh select iptables-multiport"
                echo "fail2ban fail2ban/banaction_apache select iptables-multiport"
                echo "fail2ban fail2ban/banaction_nginx select iptables-multiport"
                echo "fail2ban fail2ban/banaction_sshd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_asterisk select iptables-multiport"
                echo "fail2ban fail2ban/banaction_courier select iptables-multiport"
                echo "fail2ban fail2ban/banaction_cyrus select iptables-multiport"
                echo "fail2ban fail2ban/banaction_dovecot select iptables-multiport"
                echo "fail2ban fail2ban/banaction_ftp select iptables-multiport"
                echo "fail2ban fail2ban/banaction_lighttpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_mail select iptables-multiport"
                echo "fail2ban fail2ban/banaction_named select iptables-multiport"
                echo "fail2ban fail2ban/banaction_pam select iptables-multiport"
                echo "fail2ban fail2ban/banaction_postfix select iptables-multiport"
                echo "fail2ban fail2ban/banaction_proftpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_pure-ftpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_sasl select iptables-multiport"
                echo "fail2ban fail2ban/banaction_sieve select iptables-multiport"
                echo "fail2ban fail2ban/banaction_squid select iptables-multiport"
                echo "fail2ban fail2ban/banaction_su select iptables-multiport"
                echo "fail2ban fail2ban/banaction_svn select iptables-multiport"
                echo "fail2ban fail2ban/banaction_vsftpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_wordpress select iptables-multiport"
            } | debconf-set-selections
            
            # 强制安装，忽略所有交互式提示
            apt install -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" fail2ban
        else
            # 使用 -y 和 -q 参数，并设置环境变量
            sudo apt update -y -q
            # 预设所有可能的交互式配置
            {
                echo "fail2ban fail2ban/banaction select iptables-multiport"
                echo "fail2ban fail2ban/banaction_ssh select iptables-multiport"
                echo "fail2ban fail2ban/banaction_apache select iptables-multiport"
                echo "fail2ban fail2ban/banaction_nginx select iptables-multiport"
                echo "fail2ban fail2ban/banaction_sshd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_asterisk select iptables-multiport"
                echo "fail2ban fail2ban/banaction_courier select iptables-multiport"
                echo "fail2ban fail2ban/banaction_cyrus select iptables-multiport"
                echo "fail2ban fail2ban/banaction_dovecot select iptables-multiport"
                echo "fail2ban fail2ban/banaction_ftp select iptables-multiport"
                echo "fail2ban fail2ban/banaction_lighttpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_mail select iptables-multiport"
                echo "fail2ban fail2ban/banaction_named select iptables-multiport"
                echo "fail2ban fail2ban/banaction_pam select iptables-multiport"
                echo "fail2ban fail2ban/banaction_postfix select iptables-multiport"
                echo "fail2ban fail2ban/banaction_proftpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_pure-ftpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_sasl select iptables-multiport"
                echo "fail2ban fail2ban/banaction_sieve select iptables-multiport"
                echo "fail2ban fail2ban/banaction_squid select iptables-multiport"
                echo "fail2ban fail2ban/banaction_su select iptables-multiport"
                echo "fail2ban fail2ban/banaction_svn select iptables-multiport"
                echo "fail2ban fail2ban/banaction_vsftpd select iptables-multiport"
                echo "fail2ban fail2ban/banaction_wordpress select iptables-multiport"
            } | sudo debconf-set-selections
            
            # 强制安装，忽略所有交互式提示
            sudo apt install -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" fail2ban
        fi
        fi
    elif [ -x "$(command -v yum)" ]; then
        log_info "使用 yum 包管理器"
        if [[ $EUID -eq 0 ]]; then
            yum install -y epel-release
            yum install -y fail2ban
        else
            sudo yum install -y epel-release
            sudo yum install -y fail2ban
        fi
    elif [ -x "$(command -v dnf)" ]; then
        log_info "使用 dnf 包管理器"
        if [[ $EUID -eq 0 ]]; then
            dnf install -y epel-release
            dnf install -y fail2ban
        else
            sudo dnf install -y epel-release
            sudo dnf install -y fail2ban
        fi
    else
        log_error "不支持的 Linux 发行版。请使用 apt、yum 或 dnf。"
        exit 1
    fi
    
    # 验证安装
    if ! command -v fail2ban-client &> /dev/null; then
        log_error "fail2ban 安装失败"
        exit 1
    fi
    log_info "fail2ban 安装成功"
}

# 检测日志文件路径
detect_log_path() {
    local log_paths=(
        "/var/log/auth.log"
        "/var/log/secure"
        "/var/log/messages"
    )
    
    for path in "${log_paths[@]}"; do
        if [ -f "$path" ]; then
            echo "$path"
            return 0
        fi
    done
    
    log_warn "未找到标准的SSH日志文件，使用默认路径"
    echo "/var/log/auth.log"
}

# 创建配置文件
create_config() {
    log_info "创建 fail2ban 配置文件..."
    
    # 获取日志路径
    local log_path=$(detect_log_path)
    
    # 创建配置文件内容
    cat > /tmp/sshd.local << 'EOF'
[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = LOG_PATH_PLACEHOLDER
maxretry = 5
bantime  = 3600
findtime = 600
ignoreip = 127.0.0.1/8 ::1
banaction = iptables-multiport
EOF
    
    # 替换日志路径
    sed -i "s|LOG_PATH_PLACEHOLDER|$log_path|g" /tmp/sshd.local
    
    log_info "配置文件已创建"
}

# 配置fail2ban
configure_fail2ban() {
    log_info "开始配置 fail2ban..."
    
    # 创建本地配置目录
    if [[ $EUID -eq 0 ]]; then
        mkdir -p /etc/fail2ban/jail.d/
    else
        sudo mkdir -p /etc/fail2ban/jail.d/
    fi
    
    # 创建配置文件
    create_config
    
    # 复制配置文件
    if [[ $EUID -eq 0 ]]; then
        cp /tmp/sshd.local /etc/fail2ban/jail.d/sshd.local
    else
        sudo cp /tmp/sshd.local /etc/fail2ban/jail.d/sshd.local
    fi
    rm -f /tmp/sshd.local
    
    log_info "配置文件已创建: /etc/fail2ban/jail.d/sshd.local"
}

# 启动服务
start_service() {
    log_info "启动 fail2ban 服务..."
    
    # 启动服务
    if [[ $EUID -eq 0 ]]; then
        systemctl enable fail2ban
        systemctl restart fail2ban
    else
        sudo systemctl enable fail2ban
        sudo systemctl restart fail2ban
    fi
    
    # 等待服务启动
    sleep 3
    
    # 检查服务状态
    if [[ $EUID -eq 0 ]]; then
        if systemctl is-active --quiet fail2ban; then
            log_info "fail2ban 服务启动成功"
        else
            log_error "fail2ban 服务启动失败"
            systemctl status fail2ban
            exit 1
        fi
    else
        if sudo systemctl is-active --quiet fail2ban; then
            log_info "fail2ban 服务启动成功"
        else
            log_error "fail2ban 服务启动失败"
            sudo systemctl status fail2ban
            exit 1
        fi
    fi
}

# 验证配置
verify_config() {
    log_info "验证配置..."
    
    # 检查fail2ban状态
    if [[ $EUID -eq 0 ]]; then
        if fail2ban-client status > /dev/null 2>&1; then
            log_info "fail2ban 运行正常"
        else
            log_error "fail2ban 运行异常"
            exit 1
        fi
        
        # 检查SSH监狱状态
        if fail2ban-client status sshd > /dev/null 2>&1; then
            log_info "SSH 防护已启用"
        else
            log_warn "SSH 防护可能未正确配置"
        fi
    else
        if sudo fail2ban-client status > /dev/null 2>&1; then
            log_info "fail2ban 运行正常"
        else
            log_error "fail2ban 运行异常"
            exit 1
        fi
        
        # 检查SSH监狱状态
        if sudo fail2ban-client status sshd > /dev/null 2>&1; then
            log_info "SSH 防护已启用"
        else
            log_warn "SSH 防护可能未正确配置"
        fi
    fi
}

# 显示安装信息
show_info() {
    echo
    log_info "=== fail2ban 安装完成 ==="
    echo
    echo "常用命令："
    if [[ $EUID -eq 0 ]]; then
        echo "  查看状态: fail2ban-client status"
        echo "  查看SSH监狱: fail2ban-client status sshd"
        echo "  查看日志: tail -f /var/log/fail2ban.log"
        echo "  解封IP: fail2ban-client set sshd unbanip <IP地址>"
    else
        echo "  查看状态: sudo fail2ban-client status"
        echo "  查看SSH监狱: sudo fail2ban-client status sshd"
        echo "  查看日志: sudo tail -f /var/log/fail2ban.log"
        echo "  解封IP: sudo fail2ban-client set sshd unbanip <IP地址>"
    fi
    echo
    echo "配置文件位置："
    echo "  /etc/fail2ban/jail.d/sshd.local"
    echo
    log_info "安装完成！"
}

# 主函数
main() {
    echo "=================================="
    echo "    fail2ban 一键安装脚本 (独立版本)"
    echo "=================================="
    echo
    
    check_root
    detect_system
    install_fail2ban
    configure_fail2ban
    start_service
    verify_config
    show_info
}

# 运行主函数
main "$@" 
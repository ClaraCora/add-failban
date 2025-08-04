# fail2ban-installer

这是一个快速为 Linux VPS 安装并配置 fail2ban 的一键脚本。

## 功能特性

- 🚀 一键安装 fail2ban
- 🔧 自动配置 SSH 防护规则
- 🛡️ 防止暴力破解攻击
- 📊 支持多种 Linux 发行版 (Ubuntu/Debian/CentOS/RHEL)
- ⚡ 自动启动并设置开机自启
- 🤖 完全非交互式安装，无需人工干预
- 🔒 自动处理配置文件冲突

## 使用方法

### 🚀 一键安装（最推荐）
```bash
# 独立版本 - 完全非交互式，无需额外文件
bash <(curl -fsSL https://raw.githubusercontent.com/ClaraCora/add-failban/main/install_standalone.sh)
```

### 📦 其他安装方式

#### 方法一：使用普通用户运行
```bash
# 直接运行
bash <(curl -fsSL https://raw.githubusercontent.com/ClaraCora/add-failban/main/install.sh)

# 或下载后运行
git clone https://github.com/ClaraCora/add-failban.git
cd add-failban
sudo bash install.sh
```

#### 方法二：使用root用户运行
```bash
# 直接运行（root版本）
bash <(curl -fsSL https://raw.githubusercontent.com/ClaraCora/add-failban/main/install_root.sh)

# 或下载后运行
git clone https://github.com/ClaraCora/add-failban.git
cd add-failban
bash install_root.sh
```

## 配置说明

安装完成后，fail2ban 将自动配置以下规则：

- **SSH 防护**：5次失败登录后封禁1小时
- **检测时间**：10分钟内
- **封禁时间**：1小时

## 非交互式安装特性

✅ **完全自动化**：无需任何人工干预
✅ **自动处理冲突**：自动解决配置文件冲突
✅ **预设配置**：自动预设所有fail2ban配置选项
✅ **静默安装**：减少不必要的输出信息
✅ **错误处理**：完善的错误检测和处理机制

## 常用命令

```bash
# 查看 fail2ban 状态
sudo fail2ban-client status

# 查看 SSH 监狱状态
sudo fail2ban-client status sshd

# 查看日志
sudo tail -f /var/log/fail2ban.log

# 手动解封 IP
sudo fail2ban-client set sshd unbanip <IP地址>

# 测试配置（需要先安装fail2ban）
sudo bash test_config.sh
```

## 支持的发行版

- Ubuntu 18.04+
- Debian 9+
- CentOS 7+
- RHEL 7+

## 注意事项

1. 请确保您有 sudo 权限
2. 建议在安装前备份重要数据
3. 安装后请测试 SSH 连接是否正常
4. 脚本会自动处理所有交互式提示，无需手动干预
5. 如果系统中已存在fail2ban配置，脚本会自动处理冲突

## 许可证

MIT License

.

.

.

.

.

.

.

.

.

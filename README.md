# [sing-box](https://github.com/SagerNet/sing-box) 安装指南

## 服务端

### 安装

1. 下载程序（**linux-amd64**）

```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/download/v1.3.4/sing-box-1.3.4-linux-amd64.tar.gz && tar -xzf /root/sb && cp -f /root/sing-box-*/sing-box /root && rm -r /root/sb /root/sing-box-* && chown root:root /root/sing-box && chmod +x /root/sing-box && mv /root/sing-box /usr/local/bin
```

2. 下载systemctl配置

```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-examples/main/sing-box.service && systemctl daemon-reload
```

3. 修改配置

4. 启动程序

```
systemctl enable --now sing-box && sleep 0.2 && systemctl status sing-box
```

| 项目 | |
| :--- | :--- |
| 程序 | **/root/sing-box** |
| 配置 | **/root/sing-box_config.json** |
| 检查 | `/root/sing-box check -c sing-box_config.json` |
| 重启 | `systemctl restart sing-box` |
| 状态 | `systemctl status sing-box` |
| 查看日志 | `journalctl -u sing-box --output cat -e` |
| 实时日志 | `journalctl -u sing-box --output cat -f` |

### 卸载

```
systemctl disable --now sing-box && rm /root/sing-box && rm /root/sing-box_config.json && rm /etc/systemd/system/sing-box.service
```

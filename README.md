## VLESS-[XTLS](https://github.com/XTLS/Xray-core/discussions/1295)-uTLS-[REALITY](https://github.com/XTLS/REALITY) 使用 [sing-box](https://github.com/SagerNet/sing-box) 安装指南

1. 下载程序（**linux-amd64**）

```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/download/v1.2.5/sing-box-1.2.5-linux-amd64.tar.gz && tar -xzf /root/sb && cp -f /root/sing-box-*/sing-box /root && rm -r /root/sb /root/sing-box-* && chown root:root /root/sing-box && chmod +x /root/sing-box
```

2. 下载配置

```
curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/chika0801/sing-box-examples/main/Tun/config_server.json
```

3. 下载systemctl配置

```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-install/main/sing-box.service && systemctl daemon-reload
```

4. 启动程序

```
systemctl enable --now sing-box && sleep 0.2 && systemctl status sing-box
```

| 项目 | |
| :--- | :--- |
| 程序 | **/root/sing-box** |
| 配置 | **/root/sing-box_config.json** |
| 检查 | `/root/sing-box check -c sing-box_config.json` |
| 查看日志 | `journalctl -u sing-box --output cat -e` |
| 实时日志 | `journalctl -u sing-box --output cat -f` |

[**客户端使用方法**](https://github.com/chika0801/sing-box-examples/tree/main/Tun)

## sing-box安装指南

1.下载程序
```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-1.0.5-linux-amd64.tar.gz && tar -xf /root/sb && mv /root/sing-box-*-linux-amd64/sing-box . && rm /root/sb -r /root/sing-box-*-linux-amd64 && chown root:root sing-box && chmod +x sing-box
```

- 下载 [sing-box](https://github.com/SagerNet/sing-box/releases)
- 程序 `/root/sing-box`
- 配置 `/root/sing-box_config.json`
- 证书 `/root/fullchain.cer`
- 私钥 `/root/private.key`
- systemctl配置文件 `/etc/systemd/system/sing-box.service`
- 查看日志 `journalctl -u sing-box --output cat -e`
- 实时日志 `journalctl -u sing-box --output cat -f`
- 官方链接 [https://sing-box.sagernet.org](https://sing-box.sagernet.org/zh/configuration/)

```
chmod +x /root/sing-box
```

```
systemctl daemon-reload && systemctl enable sing-box
```

```
systemctl start sing-box
```

```
systemctl status sing-box
```

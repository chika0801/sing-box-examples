## [sing-box](https://github.com/SagerNet/sing-box)安装指南

1.下载程序
```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-1.0.6-linux-amd64.tar.gz && tar -xf /root/sb && mv /root/sing-box-*-linux-amd64/sing-box . && rm /root/sb -r /root/sing-box-*-linux-amd64 && chown root:root sing-box && chmod +x sing-box
```

2.下载配置

Trojan-TCP-TLS
```
curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/chika0801/sing-box-install/main/Trojan-TCP-TLS/config_server.json
```

hysteria
```
curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/chika0801/sing-box-install/main/hysteria/config_server.json
```

3.下载systemctl配置文件
```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-install/main/sing-box.service
```

4.上传证书和私钥

将证书文件改名为`fullchain.cer`，将私钥文件改名为`private.key`，使用WinSCP登录你的VPS，将它们上传到`/root/`目录。

[用acme申请 SSL 证书](https://github.com/chika0801/Xray-install#1%E7%94%A8acme%E7%94%B3%E8%AF%B7-ssl-%E8%AF%81%E4%B9%A6)

[什么是 SSL 证书](https://www.kaspersky.com.cn/resource-center/definitions/what-is-a-ssl-certificate)

5.启动程序

```
systemctl daemon-reload && systemctl enable sing-box
```

```
systemctl start sing-box
```

```
systemctl status sing-box
```

- 程序 `/root/sing-box`
- 配置 `/root/sing-box_config.json`
- 证书 `/root/fullchain.cer`
- 私钥 `/root/private.key`
- systemctl配置文件 `/etc/systemd/system/sing-box.service`
- 查看日志 `journalctl -u sing-box --output cat -e`
- 实时日志 `journalctl -u sing-box --output cat -f`

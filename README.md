## [sing-box](https://github.com/SagerNet/sing-box)安装指南

1. 下载程序(Download sing-box)

```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-1.0.6-linux-amd64.tar.gz && tar -xf /root/sb && mv /root/sing-box-*/sing-box . && rm /root/sb -r /root/sing-box-* && chown root:root sing-box && chmod +x sing-box
```

2. 下载配置(Download config)

[hysteria](https://github.com/chika0801/sing-box-install/tree/main/hysteria)
```
curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/chika0801/sing-box-install/main/hysteria/config_server.json
```

3. 下载systemctl配置(Download systemctl config)

```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-install/main/sing-box.service
```

4. 上传证书和私钥(Upload certificate and private key)

- 将证书文件改名为`fullchain.cer`，将私钥文件改名为`private.key`，使用WinSCP登录你的VPS，将它们上传到`/root/`目录。(Rename the certificate file to `fullchain.cer` and the private key file to `private.key`, log in to your VPS using WinSCP, upload them to the `/root/` directory, and execute the following command.)
- [用acme申请 SSL 证书](https://github.com/chika0801/Xray-install#1%E7%94%A8acme%E7%94%B3%E8%AF%B7-ssl-%E8%AF%81%E4%B9%A6)

5. 启动程序(Start sing-box)

```
systemctl daemon-reload && systemctl enable --now sing-box
```

```
systemctl status sing-box
```

| 项目 | |
| :--- | :--- |
| 程序 | /root/sing-box |
| 配置 | /root/sing-box_config.json |
| 证书 | /root/fullchain.cer |
| 私钥 | /root/private.key |
| systemctl配置 | /etc/systemd/system/sing-box.service |
| 查看日志 | journalctl -u sing-box --output cat -e |
| 实时日志 | journalctl -u sing-box --output cat -f |

## v2rayN配置指南

1. 下载Windows客户端程序[hysteria-windows-amd64.exe](https://github.com/HyNetwork/hysteria/releases/latest/download/hysteria-windows-amd64.exe)，重命令为`hysteria.exe`，复制到v2rayN文件夹。

2. 下载客户端配置[config_client.json](https://github.com/chika0801/sing-box-install/blob/main/hysteria/config_client.json)，修改`chika.example.com`为证书中包含的域名，修改`10.0.0.1`为VPS的IP。

3. `服务器` ——> `添加自定义配置服务器` ——> `浏览(B)` ——> `选择客户端配置` ——> `Core类型 hysteria` ——> `Socks端口 50000`

![1](https://user-images.githubusercontent.com/88967758/195763557-f9706952-f2fc-466f-9787-bf00d138562d.jpg)

小技巧：只要证书在有效期内，证书中包含的域名不用解析到VPS的IP。一份证书，在多个VPS上使用。

## **配置介绍：** 

| | 无需注册域名 | 解决 TLS in TLS | 自带多路复用 | 通过 CDN 访问 |
| :--- | :---: | :---: | :---: | :---: |
| :rocket:**VLESS-XTLS-Vision** | :x: | :heavy_check_mark: | :x: | :x: |
| :rocket:**VLESS-XTLS-uTLS-REALITY** | :heavy_check_mark: | :heavy_check_mark: | :x: | :x: |
| :rocket:**VLESS-gRPC-uTLS-REALITY** | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |
| :rocket:**VLESS-H2-uTLS-REALITY** | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |
| **Hysteria** | :x: | :x: | :heavy_check_mark: | :x: |
| **Naive** | :x: | :x: | :radio_button: | :x: |
| **ShadowTLS+h2mux+padding** | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |
| **Shadowsocks+h2mux+padding** | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |
| **Trojan+h2mux+padding** | :x: | :x: | :heavy_check_mark: | :x: |
| **VMess+WebSocket+h2mux+padding** | :x: | :x: | :heavy_check_mark: | :heavy_check_mark: |
| **VMess+gRPC+padding** | :x: | :x: | :heavy_check_mark: | :heavy_check_mark: |


# [sing-box](https://github.com/SagerNet/sing-box) 安装指南

## 服务端

### 安装

1. 下载程序（**linux-amd64**）

```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/download/v1.3.4/sing-box-1.3.4-linux-amd64.tar.gz && tar -xzf /root/sb && cp -f /root/sing-box-*/sing-box /root && rm -r /root/sb /root/sing-box-* && chown root:root /root/sing-box && chmod +x /root/sing-box && mv -f /root/sing-box /usr/local/bin
```

2. 上传配置、证书和私钥

- 将配置文件改名为 **sing-box_config.json**，将证书文件改名为 **fullchain.cer**，将私钥文件改名为 **private.key**，将它们上传到 **/root** 目录

3. 下载systemctl配置

```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-examples/main/sing-box.service && systemctl daemon-reload
```

4. 启动程序

```
systemctl enable --now sing-box
```

| 项目 | |
| :--- | :--- |
| 程序 | **/usr/local/bin/sing-box** |
| 配置 | **/root/sing-box_config.json** |
| 检查 | `sing-box check -c sing-box_config.json` |
| 重启 | `systemctl restart sing-box` |
| 状态 | `systemctl status sing-box` |
| 查看日志 | `journalctl -u sing-box --output cat -e` |
| 实时日志 | `journalctl -u sing-box --output cat -f` |

### 卸载

```
systemctl disable --now sing-box
```

```
rm -f /usr/local/bin/sing-box /root/sing-box_config.json /etc/systemd/system/sing-box.service
```

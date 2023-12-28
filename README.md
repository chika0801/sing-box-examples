## **配置介绍：** 

### 基于 TCP 的代理协议

| 协议(组合) | [Multiplex](https://sing-box.sagernet.org/configuration/shared/multiplex/) | [TCP Brutal](https://sing-box.sagernet.org/configuration/shared/tcp-brutal/) | MPTCP |
| :--- | :---: | :---: | :---: |
| [**Shadowsocks**](Shadowsocks) | 支持 | :heavy_check_mark: | :heavy_check_mark: |
| [**Trojan**](Trojan) | 支持 | :heavy_check_mark: | :heavy_check_mark: |
| [**VLESS-Vision-TLS**](VLESS-Vision-TLS) | 不支持 **1** | :x: **1** | :heavy_check_mark: |
| [**VLESS-Vision-REALITY**](VLESS-Vision-REALITY) | 不支持 **1** | :x: **1** | :heavy_check_mark: |
| [**VLESS-gRPC-REALITY**](VLESS-gRPC-REALITY) | 自带 | :x: | :heavy_check_mark: |
| [**VLESS-HTTP2-REALITY**](VLESS-HTTP2-REALITY) | 自带 | :x: | :heavy_check_mark: |
| [**VLESS-gRPC-TLS**](VLESS-gRPC-TLS) | 自带 | :x: | :heavy_check_mark: |
| [**VMess**](VMess) | 支持 | :heavy_check_mark: | :heavy_check_mark: |
| [**VMess-WebSocket**](VMess-WebSocket) | 支持 | :heavy_check_mark: | :heavy_check_mark: |
| [**VMess-WebSocket-TLS**](VMess-WebSocket-TLS) | 支持 | :heavy_check_mark: | :heavy_check_mark: |
| [**VMess-HTTPUpgrade-TLS**](VMess-HTTPUpgrade-TLS) | 支持 | :heavy_check_mark: | :heavy_check_mark: |

**1：** `"flow": ""` 留空，或不写 `"flow": ""` 时支持

[**TCP Brutal 使用指南**](TCP_Brutal#readme)

> TCP Brutal 配置需在[客户端](TCP_Brutal/config_client.json#L24-L35)，[服务端](TCP_Brutal/config_server.json#L17-L25)同时启用

### 基于 UDP 的代理协议

| 协议 |
| :--- |
| [**Hysteria**](Hysteria) |
| [**Hysteria2**](Hysteria2) |
| [**TUIC**](TUIC) |

## 一键脚本 [sing-box-install](https://github.com/chise0713/sing-box-install) 

安装正式版

```
bash -c "$(curl -L sing-box.vercel.app)" @ install
```

安装预发布版

```
bash -c "$(curl -L sing-box.vercel.app)" @ install --beta
```

编译安装最新版

```
bash -c "$(curl -L sing-box.vercel.app)" @ install --go
```

卸载

```
bash -c "$(curl -L sing-box.vercel.app)" @ remove
```

| 项目 | |
| :--- | :--- |
| 程序 | **/usr/local/bin/sing-box** |
| 配置 | **/usr/local/etc/sing-box/config.json** |
| 工作目录 | **/var/lib/sing-box** |
| 热载 | `systemctl reload sing-box` |
| 重启 | `systemctl restart sing-box` |
| 状态 | `systemctl status sing-box` |
| 查看日志 | `journalctl -u sing-box -o cat -e` |
| 实时日志 | `journalctl -u sing-box -o cat -f` |

## 服务端

### 安装

1. 下载程序（**linux-amd64**）或 [编译程序](compile_sing-box.md)

```
curl -Lo sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/latest/download/$(curl https://api.github.com/repos/SagerNet/sing-box/releases|grep -E '"name": "sing-box-.*-linux-amd64.tar.gz"'|grep -Pv '(alpha|beta|rc)'|sed -n 's/.*"name": "\(.*\)".*/\1/p'|head -1) && tar -xzf sing-box.tar.gz && cp -f sing-box-*/sing-box . && rm -r sing-box.tar.gz sing-box-* && chown root:root sing-box && chmod +x sing-box && mv -f sing-box /usr/local/bin/
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
| geoip | **/root/geoip.db** |
| geosite | **/root/geosite.db** |
| 热载 | `systemctl reload sing-box` |
| 重启 | `systemctl restart sing-box` |
| 状态 | `systemctl status sing-box` |
| 查看日志 | `journalctl -u sing-box -o cat -e` |
| 实时日志 | `journalctl -u sing-box -o cat -f` |

### 卸载

```
systemctl disable --now sing-box && rm -f /usr/local/bin/sing-box /root/sing-box_config.json /etc/systemd/system/sing-box.service
```

## 客户端

### Android 使用方法：

1. 下载Android客户端程序[SFA-arm64-v8a.apk](https://github.com/SagerNet/sing-box/releases)。

2. 参考[客户端配置](Tun/config_client_android.json)示例，按需修改后导入。

### Windows 使用方法：

1. 下载Windows客户端程序[sing-box-windows-amd64.zip](https://github.com/SagerNet/sing-box/releases)。

2. 新建一个批处理文件，内容为：

```
start /min sing-box.exe run
```

3. 参考[客户端配置](Tun/config_client_windows.json)示例，按需修改后将文件名改为 **config.json**，与 **sing-box.exe**，批处理文件放在同一文件夹里。

4. 右键点击 **sing-box.exe** 选择属性，选择兼容性，选择以管理员身份运行此程序，确定。

5. 运行批处理文件，在弹出的用户账户控制对话框中，选择是。

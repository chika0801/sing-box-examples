## [sing-box](https://github.com/SagerNet/sing-box)安装指南

1. 下载程序（linux-amd64）

```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/download/v1.1/sing-box-1.1-linux-amd64.tar.gz && tar -xf /root/sb && mv /root/sing-box-*/sing-box . && rm /root/sb -r /root/sing-box-* && chown root:root sing-box && chmod +x sing-box
```

2. 下载配置

```
curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/chika0801/sing-box-install/main/config_server.json
```

3. 下载systemctl配置

```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-install/main/sing-box.service
```

4. 上传证书和私钥

- 将证书文件改名为`fullchain.cer`，将私钥文件改名为`private.key`，使用WinSCP登录你的VPS，将它们上传到`/root/`目录。

5. 启动程序

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
| 检查 | /root/sing-box check -c sing-box_config.json
| 查看日志 | journalctl -u sing-box --output cat -e |
| 实时日志 | journalctl -u sing-box --output cat -f |

## v2rayN配置指南

1. 下载Windows客户端程序[hysteria-windows-amd64.exe](https://github.com/HyNetwork/hysteria/releases/latest/download/hysteria-windows-amd64.exe)，重命令为`hysteria.exe`，复制到v2rayN文件夹。

2. 下载客户端配置[config_client.json](https://raw.githubusercontent.com/chika0801/sing-box-install/main/config_client.json)，修改`chika.example.com`为证书中包含的域名，修改`10.0.0.1`为VPS的IP。

3. `服务器` ——> `添加自定义配置服务器` ——> `浏览(B)` ——> `选择客户端配置` ——> `Core类型 hysteria` ——> `Socks端口 50000`

![1](https://user-images.githubusercontent.com/88967758/195763557-f9706952-f2fc-466f-9787-bf00d138562d.jpg)

小技巧：只要证书在有效期内，证书中包含的域名不用解析到VPS的IP。一份证书，在多个VPS上使用。

## ShadowSocksR Plus+配置指南

| 选项 | 值 | 对应参数 |
| :--- | :--- | :--- |
| 服务器节点类型 | Hysteria |
| 别名（可选） |  |
| 服务器地址 | VPS的IP | "server" |
| 端口 | 16384 | "server" |
| 传输协议 | udp | "protocol" |
| 验证类型 | string |  |
| 验证载荷 | chika | "auth_str" |
| QUIC 连接接收窗口 | 4194304 | "recv_window" |
| QUIC 流接收窗口 | 1677721 | "recv_window_conn" |
| 禁用 MTU 探测 | 不勾 | "disable_mtu_discovery" |
| 上行链路容量 | 50 | "up_mbps" |
| 下行链路容量 | 150 | "down_mbps" |
| 混淆密码（可选） | 留空 | "obfs" |
| TLS 主机名 | 证书中包含的域名 | "server_name" |
| QUIC TLS ALPN | h3 | "alpn" |
| 允许不安全连接 | 不勾 | "insecure" |
| 自签证书 | 不勾 |  |
| TCP 快速打开 | 勾上 | "fast_open" |
| 启用自动切换 | 不勾 |  |
| 本地端口 | 1234 |  |

## PassWall配置指南

| 选项 | 值 | 对应参数 |
| :--- | :--- | :--- |
| 节点备注 |  |  |
| 类型 | Hysteria |  |
| 地址 | VPS的IP | "server" |
| 端口 | 16384 | "server" |
| 端口跳跃额外端口 | 留空 | "server" |
| 协议名称 | UDP | "protocol" |
| 混淆密码 | 留空 | "obfs" |
| 认证类型 | STRING |  |
| 认证密码 | chika | "auth_str" |
| QUIC TLS ALPN | h3 | "alpn" |
| 域名 | 证书中包含的域名 | "server_name" |
| 允许不安全连接 | 不勾 | "insecure" |
| 最大上行(Mbps) | 50 | "up_mbps" |
| 最大下行(Mbps) | 150 | "down_mbps" |
| QUIC 流接收窗口 | 1677721 | "recv_window_conn" |
| QUIC 连接接收窗口 | 4194304 | "recv_window" |
| 握手超时 | 留空 | "handshake_timeout" |
| 空闲超时 | 留空 | "idle_timeout" |
| 端口跳跃时间 | 留空 | "hop_interval" |
| 禁用 MTU 检测 | 不勾 | "disable_mtu_discovery" |

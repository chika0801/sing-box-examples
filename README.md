# [TCP Brutal](https://github.com/apernet/tcp-brutal) 使用指南

**Brutal**： 这是 Hysteria 自有的拥塞控制算法。与 BBR 不同，Brutal 采用固定速率模型，丢包或 RTT 变化不会降低速度。相反，如果无法达到预定的目标速率，反而会根据计算的丢包率提高发送速率来进行补偿。Brutal 只在你知道（并正确设置了）当前网络的最大速度时才能正常运行。其擅长在拥塞的网络中抢占带宽，因此得名。

> Brutal 如果带宽设置低于实际最大值也能正常运行；相当于限速。重要的是不要将其设置得高于实际最大值，否则会因为补偿机制导致连接速度慢、不稳定，且浪费流量。

[Hysteria 是多倍发包吗？](https://hysteria.network/zh/docs/misc/Hysteria-Brutal/)

[My response to the recent controversy about TCP Brutal](https://gist.github.com/tobyxdd/0993ac063b2eee94f7d36ddd786f52ce)

## 服务端安装 [TCP Brutal](https://github.com/apernet/tcp-brutal/blob/master/README.zh.md#%E7%94%A8%E6%88%B7%E6%8C%87%E5%8D%97)

## 客户端配置

```jsonc
            "multiplex": {
                "enabled": true,
                "protocol": "h2mux", // smux / yamux / h2mux
                "max_connections": 1, // 必须为 1
                "min_streams": 4,
                "padding": true, // false / true
                "brutal": {
                    "enabled": true,
                    "up_mbps": 50,
                    "down_mbps": 1000
                }
            }
```

**支持的：[ShadowTLS](ShadowTLS) / [Shadowsocks](Shadowsocks) / [Trojan](Trojan) / [VLESS](VLESS-XTLS-Vision) / [VLESS-REALITY](VLESS-XTLS-uTLS-REALITY) / [VMess-WebSocket](VMess-WebSocket)**

1. **VLESS / VLESS-REALITY** 中 `"flow": ""` 必须留空

2. 两端 **"padding"** 必须一致

3. **"up_mbps" / "down_mbps"** 必填，不会生效

<details> <summary>示例配置</summary>

```jsonc
{
    "inbounds": [
        {
            "type": "mixed",
            "listen": "::",
            "listen_port": 10000
        }
    ],
    "outbounds": [
        {
            "type": "vless",
            "server": "233.33.33.33",
            "server_port": 443,
            "uuid": "chika",
            "flow": "",
            "tls": {
                "enabled": true,
                "server_name": "www.lovelive-anime.jp",
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
             },
            "packet_encoding": "xudp",
            "multiplex": {
                "enabled": true,
                "protocol": "h2mux",
                "max_connections": 1,
                "min_streams": 4,
                "padding": true,
                "brutal": {
                    "enabled": true,
                    "up_mbps": 50,
                    "down_mbps": 1000
                }
            }
        }
    ]
}
```

</details>

## 服务端配置

```jsonc
            "multiplex": {
                "enabled": true,
                "padding": true, // false / true
                "brutal": {
                    "enabled": true,
                    "up_mbps": 100, // 客户端的下行速率
                    "down_mbps": 1000
                }
            }
```

**支持的：[ShadowTLS](ShadowTLS) / [Shadowsocks](Shadowsocks) / [Trojan](Trojan) / [VLESS](VLESS-XTLS-Vision) / [VLESS-REALITY](VLESS-XTLS-uTLS-REALITY) / [VMess-WebSocket](VMess-WebSocket)**

1. **VLESS / VLESS-REALITY** 中 `"flow": ""` 必须留空

2. 两端 **"padding"** 必须一致

3. **"up_mbps" / "down_mbps"** 必填，**"down_mbps"** 不会生效

<details> <summary>示例配置</summary>

```jsonc
{
    "inbounds": [
        {
            "type": "vless",
            "listen": "::",
            "listen_port": 443,
            "users": [
                {
                    "uuid": "chika",
                    "flow": ""
                }
            ],
            "tls": {
                "enabled": true,
                "certificate_path": "/root/fullchain.cer",
                "key_path": "/root/private.key"
            },
            "multiplex": {
                "enabled": true,
                "padding": true,
                "brutal": {
                    "enabled": true,
                    "up_mbps": 100,
                    "down_mbps": 1000
                }
            }
        }
    ],
    "outbounds": [
        {
            "type": "direct"
        }
    ]
}
```

</details>

# [sing-box](https://github.com/SagerNet/sing-box) 安装指南

## 一键脚本 [sing-box-install](https://github.com/chise0713/sing-box-install) 

安装正式版

```
bash -c "$(curl -L https://sing-box.vercel.app)" @ install
```

安装预发布版

```
bash -c "$(curl -L https://sing-box.vercel.app)" @ install --beta
```

编译安装最新版

```
bash -c "$(curl -L https://sing-box.vercel.app)" @ install --go
```

卸载

```
bash -c "$(curl -L https://sing-box.vercel.app)" @ remove
```

| 项目 | |
| :--- | :--- |
| 程序 | **/usr/local/bin/sing-box** |
| 配置 | **/usr/local/etc/sing-box/config.json** |
| geoip | **/usr/local/share/sing-box/geoip.db** |
| geosite | **/usr/local/share/sing-box/geosite.db** |
| 热载 | `systemctl reload sing-box` |
| 重启 | `systemctl restart sing-box` |
| 状态 | `systemctl status sing-box` |
| 查看日志 | `journalctl -u sing-box -o cat -e` |
| 实时日志 | `journalctl -u sing-box -o cat -f` |

## 服务端

### 安装

1. 下载程序（**linux-amd64**）或 [编译程序](compile_sing-box.md)

```
curl -Lo sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/download/v1.6.2/sing-box-1.6.2-linux-amd64.tar.gz && tar -xzf sing-box.tar.gz && cp -f sing-box-*/sing-box . && rm -r sing-box.tar.gz sing-box-* && chown root:root sing-box && chmod +x sing-box && mv -f sing-box /usr/local/bin/
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

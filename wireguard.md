使用 **waro-go**，注册warp，导出wireguard配置

```
mkdir warp && curl -sLo ./warp/warp https://gitlab.com/ProjectWARP/warp-go/-/releases/v1.0.8/downloads/warp-go_1.0.8_linux_amd64.tar.gz && tar -xzf ./warp/warp -C ./warp && cp ./warp/warp-go . && chmod 0755 warp-go && rm -r warp && ./warp-go --register && ./warp-go -export-singbox wireguard.json
```

打开 **wireguard.json**，复制"private_key"的值，粘贴到"private_key": "",处，复制"reserved"的值，粘贴到"reserved":[0, 0, 0],处

**"outbounds"**
```
        {
            "type": "wireguard",
            "tag": "wireguard-out",
            "server": "engage.cloudflareclient.com",
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32"
            ],
            "private_key": "",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0],
            "mtu": 1280
        }
```

编辑 **/root/sing-box_config.json**，按需增加 **"route"**，**"outbounds"**，**"inbounds"** 的内容（注意检查json格式），输入 `systemctl restart sing-box` 重启sing-box，访问ip.sb查看是否为Cloudflare的IP

**"route"**
```
        "rules": [
            {
                "domain_keyword": [
                    "ip.sb"
                ],
                "geosite": [
                    "openai"
                ],
                "geoip": [
                    "cn"
                ],
                "outbound": "wireguard-out"
            }
        ]
```

**"inbounds"**
```
            "sniff": true,
            "sniff_override_destination": true,
            "domain_strategy": "ipv4_only",
```

**VLESS-XTLS-uTLS-REALITY** 配置示例

```
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "route": {
        "rules": [
            {
                "domain_keyword": [
                    "ip.sb"
                ],
                "geosite": [
                    "openai"
                ],
                "geoip": [
                    "cn"
                ],
                "outbound": "wireguard-out"
            }
        ]
    },
    "inbounds": [
        {
            "type": "vless",
            "tag": "vless-in",
            "listen": "::",
            "listen_port": 443,
            "sniff": true,
            "sniff_override_destination": true,
            "domain_strategy": "ipv4_only",
            "users": [
                {
                    "uuid": "ee48f7be-6ae9-5654-9b61-8466aa8e16bc", // 执行 ./sing-box generate uuid 生成
                    "flow": "xtls-rprx-vision"
                }
            ],
            "tls": {
                "enabled": true,
                "server_name": "www.lovelive-anime.jp", // 客户端可用的 serverName 列表，暂不支持 * 通配符
                "reality": {
                    "enabled": true,
                    "handshake": {
                        "server": "www.lovelive-anime.jp", // 目标网站最低标准：国外网站，支持 TLSv1.3、X25519 与 H2，域名非跳转用（主域名可能被用于跳转到 www）
                        "server_port": 443
                    },
                    "private_key": "2KZ4uouMKgI8nR-LDJNP1_MHisCJOmKGj9jUjZLncVU", // 执行 ./sing-box generate reality-keypair 生成，填 "PrivateKey" 的值
                    "short_id": [ // 客户端可用的 shortId 列表，可用于区分不同的客户端
                        "6ba85179e30d4fc2" // 0 到 f，长度为 2 的倍数，长度上限为 16，可留空，或执行 openssl rand -hex 8 生成
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "block",
            "tag": "block"
        },
        {
            "type": "wireguard",
            "tag": "wireguard-out",
            "server": "engage.cloudflareclient.com",
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32"
            ],
            "private_key": "sOL9HjJEqi7Xd0gtm6C2CWoDtsxXXYpJyj10Pi10KWM=",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[19, 152, 142],
            "mtu": 1280
        }
    ]
}
```

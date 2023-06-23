使用 **warp-reg**，注册warp账号

```
curl -sLo warp-reg https://github.com/badafans/warp-reg/releases/download/v1.0/main-linux-amd64 && chmod +x warp-reg && ./warp-reg && rm warp-reg
```

使用 **api.zeroteam.top**，获取warp账号

```
curl -sLo /root/warp "https://api.zeroteam.top/warp?format=sing-box" > /dev/null && grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]' warp && rm warp
```

- 复制输出的 IPv6 地址，替换下面配置中的 `2606:4700::`
- 复制输出的 `private_key` 值，粘贴到下面配置中 `private_key` 后的 `""` 中
- 复制输出的 `reserved` 值，粘贴到下面配置中 `reserved` 后的 `[]` 中

**"outbounds"**
```jsonc
        {
            "type": "direct",
            "tag": "warp-IPv4-out",
            "detour": "wireguard-out",
            "domain_strategy": "ipv4_only"
        },
        {
            "type": "direct",
            "tag": "warp-IPv6-out",
            "detour": "wireguard-out",
            "domain_strategy": "ipv6_only"
        },
        {
            "type": "wireguard",
            "tag": "wireguard-out",
            "server": "162.159.192.1",  // 或填写 engage.cloudflareclient.com
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32",
                "2606:4700::/128" // 粘贴你获得的 warp IPv6 地址，结尾加 /128
            ],
            "private_key": "", // 粘贴你的 "private_key" 值
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0], // 粘贴你的 "reserved" 值
            "mtu": 1280
        }
```

编辑 **/root/sing-box_config.json**，按需增加 **"route"**，**"inbounds"**，**"outbounds"** 的内容（注意检查json格式），输入 `systemctl restart sing-box` 重启sing-box，访问[chat.openai.com/cdn-cgi/trace](https://chat.openai.com/cdn-cgi/trace)查看是否为Cloudflare的IP。

**"route"**
```jsonc
            {
                "geosite": [
                    "openai"
                ],
                "outbound": "warp-IPv4-out" // 若需使用Cloudflare的IPv6，改为 "warp-IPv6-out"
            }
```

**"inbounds"**
```jsonc
            "sniff": true,
            "sniff_override_destination": true,
```

**服务端配置示例**

```jsonc
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "route": {
        "rules": [
            {
                "geosite": [
                    "openai"
                ],
                "outbound": "warp-IPv4-out" // 若需使用Cloudflare的IPv6，改为 "warp-IPv6-out"
            }
        ]
    },
    "inbounds": [
        {
            "sniff": true,
            "sniff_override_destination": true,
            // 粘贴你的服务端配置
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "direct",
            "tag": "warp-IPv4-out",
            "detour": "wireguard-out",
            "domain_strategy": "ipv4_only"
        },
        {
            "type": "direct",
            "tag": "warp-IPv6-out",
            "detour": "wireguard-out",
            "domain_strategy": "ipv6_only"
        },
        {
            "type": "wireguard",
            "tag": "wireguard-out",
            "server": "162.159.192.1",
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32",
                "/128" // 粘贴你获得的 warp IPv6 地址，结尾加 /128
            ],
            "private_key": "", // 粘贴你的 "private_key" 值
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0], // 粘贴你的 "reserved" 值
            "mtu": 1280
        }
    ]
}
```

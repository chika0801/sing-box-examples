### 使用 **[warp-reg](https://github.com/badafans/warp-reg)**，注册warp账号

```
curl -sLo warp-reg https://github.com/badafans/warp-reg/releases/download/v1.0/main-linux-amd64 && chmod +x warp-reg && ./warp-reg && rm warp-reg
```

### 使用 **[warp-reg.sh](https://github.com/chise0713/warp-reg.sh)**，注册warp账号

```
bash -c "$(curl -L warp-reg.vercel.app)"
```

### 使用 **api.zeroteam.top**，获取warp账号

```
curl -sL "https://api.zeroteam.top/warp?format=sing-box" | grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]'
```

- 复制输出的 IPv6 地址，替换下面配置中的 `2606:4700::`
- 复制输出的 `private_key` 值，粘贴到下面配置中 `private_key` 后的 `""` 中
- 复制输出的 `reserved` 值，粘贴到下面配置中 `reserved` 后的 `[]` 中

### "outbounds"

```jsonc
        {
            "type": "direct",
            "tag": "warp-IPv4",
            "detour": "warp",
            "domain_strategy": "ipv4_only"
        },
        {
            "type": "direct",
            "tag": "warp-IPv6",
            "detour": "warp",
            "domain_strategy": "ipv6_only"
        },
        {
            "type": "wireguard",
            "tag": "warp",
            "server": "162.159.192.1", // IPv6 地址 2606:4700:d0::a29f:c001，或填写域名 engage.cloudflareclient.com
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32",
                "2606:4700::/128" // 粘贴你的 warp IPv6 地址，结尾加 /128
            ],
            "private_key": "", // 粘贴你的 "private_key" 值
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0], // 粘贴你的 "reserved" 值
            "mtu": 1280
        }
```

编辑 **/root/sing-box_config.json**，按需增加 **"route"**，**"inbounds"**，**"outbounds"** 的内容（注意检查json格式），输入 `systemctl restart sing-box` 重启sing-box，访问[chat.openai.com/cdn-cgi/trace](https://chat.openai.com/cdn-cgi/trace)查看是否为Cloudflare的IP。

### "route"

```jsonc
            {
                "geosite": [
                    "openai"
                ],
                "outbound": "warp-IPv4" // 若需使用 cloudflare 的 IPv6，改为 "warp-IPv6"
            }
```

### "inbounds"

```jsonc
            "sniff": true,
            "sniff_override_destination": true,
```

### 服务端配置示例

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
                "outbound": "warp-IPv4"
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
            "tag": "warp-IPv4",
            "detour": "warp",
            "domain_strategy": "ipv4_only"
        },
        {
            "type": "direct",
            "tag": "warp-IPv6",
            "detour": "warp",
            "domain_strategy": "ipv6_only"
        },
        {
            "type": "wireguard",
            "tag": "warp",
            "server": "162.159.192.1",
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32",
                "/128"
            ],
            "private_key": "",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0],
            "mtu": 1280
        }
    ]
}
```

### 另一种方式 1

```jsonc
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "tag": "dns",
                "address": "https://1.1.1.1/dns-query",
                "address_resolver": "dns_resolver",
                "detour": "direct"
            },
            {
                "tag": "dns_ipv6",
                "address": "https://1.1.1.1/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "ipv6_only",
                "detour": "direct"
            },
            {
                "tag": "dns_resolver",
                "address": "1.1.1.1",
                "strategy": "ipv4_only",
                "detour": "direct"
            }
        ],
        "rules": [
            {
                "rule_set": "geosite-openai",
                "server": "dns_ipv6"
            }
        ],
        "final": "dns"
    },
    "route": {
        "rule_set": [
            {
                "tag": "geosite-openai",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-openai.srs",
                "download_detour": "direct"
            }
        ],
        "rules": [
            {
                "rule_set": "geosite-openai",
                "outbound": "warp"
            }
        ],
        "final": "direct"
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
            "type": "wireguard",
            "tag": "warp",
            "server": "162.159.192.1",
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32",
                "/128"
            ],
            "private_key": "",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0],
            "mtu": 1280
        }
    ],
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "cache.db"
        }
    }
}
```

### 另一种方式 2

```jsonc
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "inbounds": [
        {
            "sniff": true,
            "sniff_override_destination": true,
            "domain_strategy": "prefer_ipv6",
            // 粘贴你的服务端配置
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "wireguard",
            "tag": "warp",
            "server": "162.159.192.1",
            "server_port": 2408,
            "local_address": [
                "172.16.0.2/32",
                "/128"
            ],
            "private_key": "",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[0, 0, 0],
            "mtu": 1280
        }
    ]
}
```

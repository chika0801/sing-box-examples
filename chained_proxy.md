**客户端**

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
                    "cn",
                    "private"
                ],
                "geoip": [
                    "cn",
                    "private"
                ],
                "outbound": "direct"
            }
        ]
    },
    "inbounds": [
        {
            "type": "mixed",
            "tag": "mixed-in",
            "listen": "::",
            "listen_port": 10000
        }
    ],
    "outbounds": [
        {
            "type": "shadowsocks",
            "tag": "proxy",
            "server": "127.0.0.1",
            "server_port": 80,
            "method": "2022-blake3-aes-128-gcm",
            "password": "3P+xaSaFiXsrQ1KCr2Xvxg==",
            "detour": "socks"
        },
        {
            "type": "socks",
            "tag": "socks",
            "server": "127.0.0.1",
            "server_port": 50000
        },
        {
            "type": "direct",
            "tag": "direct"
        }
    ]
}
```

**服务端**

```jsonc
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "inbounds": [
        {
            "type": "shadowsocks",
            "tag": "shadowsocks-in",
            "listen": "127.0.0.1",
            "listen_port": 80,
            "method": "2022-blake3-aes-128-gcm",
            "password": "3P+xaSaFiXsrQ1KCr2Xvxg=="
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        }
    ]
}
```

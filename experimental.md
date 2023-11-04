client
```jsonc
    "outbounds": [
        {
            "type": "vless",
            "server": "",
            "server_port": 443,
            "uuid": "",
            "flow": "xtls-rprx-vision",
            "tls": {
                "enabled": true,
                "server_name": "",
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                },
                "reality": {
                    "enabled": true,
                    "public_key": "",
                    "short_id": ""
                }
            },
            "packet_encoding": "xudp",
            "multiplex": {
                "enabled": false,
                "padding": false,
                "brutal": {  // experimental
                    "enabled": true,
                    "up_mbps": 20,
                    "down_mbps": 100
                }
            },
            "tcp_multi_path": true // experimental
        }
    ]
```

server
```jsonc
    "inbounds": [
        {
            "type": "vless",
            "listen": "::",
            "listen_port": 443,
            "users": [
                {
                    "uuid": "",
                    "flow": "xtls-rprx-vision"
                }
            ],
            "tls": {
                "enabled": true,
                "server_name": "",
                "reality": {
                    "enabled": true,
                    "handshake": {
                        "server": "",
                        "server_port": 443
                    },
                    "private_key": "",
                    "short_id": [
                        ""
                    ]
                }
            },
            "multiplex": {
                "enabled": false,
                "padding": false,
                "brutal": {  // experimental
                    "enabled": true,
                    "up_mbps": 100,
                    "down_mbps": 20
                }
            },
            "tcp_multi_path": true // experimental
        }
    ]
```

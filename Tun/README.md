### 工作流程

1. 由 **sing-box** 提供 **Tun** 模式（透明代理环境），接管程序发出的网络访问请求（域名或IP）。域名进入 **"dns"** 部分，按预设的规则进行匹配并做DNS解析，解析返回的IP（直接请求的IP）进入 **"route"** 部分。使用 **"sniff"** 参数，获得DNS解析前的域名（直接请求的IP无域名）。IP和域名作为条件，按预设的规则进行分流。客户端发送到服务端的是 **IP**，并且不使用 **"sniff_override_destination"** 参数，不会把IP还原成域名。
2. 服务端接收到客户端发送来的 **IP**，并且不使用 **"sniff"** + **"sniff_override_destination"** 参数，不会把IP还原成域名。

### 注意事项：

1. 以 Windows 客户端配置举例，若你的客户端配置中 **"server"** 是填的域名。域名进入 **"dns"** 部分，会命中下面的规则，将使用系统默认DNS将域名解析成IP。

```json
            {
                "outbound": [
                    "any"
                ],
                "server": "dns_direct"
            }
```

2. 若直连的 Windows 可执行程序，地址是填的域名。域名进入 **"dns"** 部分，按预设的规则进行匹配。当未命中任何规则时，使用第1个DNS服务器做DNS解析，需确保此DNS服务器使用的 **"detour": "proxy"** 状态正常。当命中某个规则时，使用对应DNS服务器做DNS解析，需确保此DNS服务器使用的对应 **"detour": ""** 状态正常。

```json
            {
                "tag": "dns_proxy",
                "address": "tls://1.1.1.1",
                "address_resolver": "dns_direct",
                "strategy": "ipv4_only",
                "detour": "proxy"
            },
```

## 工作流程

1. 以 [Windows 客户端配置举例](config_client_windows.json)，由 **sing-box** 提供 **Tun** 模式（透明代理环境），接管程序发出的网络访问请求（域名或IP）。域名进入 `"dns"` 部分，按预设的规则进行匹配并做DNS解析，解析返回的IP（直接请求的IP）进入 `"route"` 部分。使用 **"sniff"** 参数，获得DNS解析前的域名（直接请求的IP无域名）。IP和域名作为条件，按预设的规则进行分流。客户端发送到服务端的是 **IP**，并且不使用 **"sniff_override_destination"** 参数，不会把IP还原成域名。

3. 服务端接收到客户端发送来的 **IP**，并且不使用 **"sniff"** + **"sniff_override_destination"** 参数，不会把IP还原成域名。

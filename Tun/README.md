**工作流程**

1. 由 **sing-box** 提供 **Tun** 模式（透明代理环境），接管程序发出的网络访问请求（域名或IP）。域名进入 **"dns"** 部分，按预设的规则进行DNS解析，解析返回的IP（直接请求的IP）进入 **"route"** 部分。使用 **"sniff"** 参数，获得DNS解析前的域名（直接请求的IP无域名）。IP和域名作为条件，按预设的规则进行分流。客户端发送到服务端的是 **IP**，并且不使用 **"sniff_override_destination"** 参数，不会把IP还原成域名。
2. 服务端接收到客户端发送来的 **IP**，并且不使用 **"sniff"** + **"sniff_override_destination"** 参数，不会把IP还原成域名。

**注意事项：**

1. 默认 **sing-box** 使用最新版本。
2. 协议组合用 **VLESS-XTLS-uTLS-REALITY** 举例，如需改用其它协议组合，请自行参照修改。

**Android 客户端使用方法：**

1. 安装 [客户端](https://install.appcenter.ms/users/nekohasekai/apps/sfa/distribution_groups/publictest)
3. 参考 [客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_android.json) 示例，按需修改后导入

**Windows 客户端使用方法：**

1. 新建一个批处理文件，内容为 `start /min sing-box.exe run`
2. 参考 [客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_windows.json) 示例，按需修改后将文件名改为 **config.json**，与 **sing-box.exe** 放在同一文件夹里
3. 右键点击 **sing-box.exe**，选择兼容性，选择以管理员身份运行此程序，确定
4. 运行批处理文件，同意用户账户控制，启动 **sing-box**

**参考链接**

1. https://sing-box.sagernet.org/zh/faq/fakeip/
2. https://sekai.icu/posts/udp-fqdn-in-transport-proxy/

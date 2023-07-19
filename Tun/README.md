### 快速安装

1. 下载程序（**linux-amd64**）

```
curl -Lo /root/sb https://github.com/SagerNet/sing-box/releases/download/v1.3.0/sing-box-1.3.0-linux-amd64.tar.gz && tar -xzf /root/sb && cp -f /root/sing-box-*/sing-box /root && rm -r /root/sb /root/sing-box-* && chown root:root /root/sing-box && chmod +x /root/sing-box
```

2. 下载配置

```
curl -Lo /root/sing-box_config.json https://raw.githubusercontent.com/chika0801/sing-box-examples/main/Tun/config_server.json
```

3. 下载systemctl配置

```
curl -Lo /etc/systemd/system/sing-box.service https://raw.githubusercontent.com/chika0801/sing-box-examples/main/sing-box.service && systemctl daemon-reload
```

4. 启动程序

```
systemctl enable --now sing-box && sleep 0.2 && systemctl status sing-box
```

| 项目 | |
| :--- | :--- |
| 程序 | **/root/sing-box** |
| 配置 | **/root/sing-box_config.json** |
| 检查 | `/root/sing-box check -c sing-box_config.json` |
| 查看日志 | `journalctl -u sing-box --output cat -e` |
| 实时日志 | `journalctl -u sing-box --output cat -f` |

### 工作流程

1. 由 **sing-box** 提供 **Tun** 模式（透明代理环境），接管程序发出的网络访问请求（域名或IP）。域名进入 **"dns"** 部分，按预设的规则进行匹配并做DNS解析，解析返回的IP（直接请求的IP）进入 **"route"** 部分。使用 **"sniff"** 参数，获得DNS解析前的域名（直接请求的IP无域名）。IP和域名作为条件，按预设的规则进行分流。客户端发送到服务端的是 **IP**，并且不使用 **"sniff_override_destination"** 参数，不会把IP还原成域名。
2. 服务端接收到客户端发送来的 **IP**，并且不使用 **"sniff"** + **"sniff_override_destination"** 参数，不会把IP还原成域名。

### 注意事项：

1. 需要自行粘贴你的客户端和服务端配置到相应位置。
2. 以 Windows 客户端配置举例，若你的客户端配置中 **"server"** 是填的域名。域名进入 **"dns"** 部分，会命中下面的规则，将使用系统默认DNS将域名解析成IP。

```json
            {
                "outbound": [
                    "any"
                ],
                "server": "dns_direct"
            }
```

3. 若直连的 Windows 可执行程序，地址是填的域名。域名进入 **"dns"** 部分，按预设的规则进行匹配。当未命中任何规则时，使用第1个DNS服务器做DNS解析，需确保此DNS服务器使用的 **"detour": "proxy"** 状态正常。当命中某个规则时，使用对应DNS服务器做DNS解析，需确保此DNS服务器使用的对应 **"detour": ""** 状态正常。

```json
            {
                "tag": "dns_proxy",
                "address": "tls://1.1.1.1",
                "address_resolver": "dns_direct",
                "strategy": "ipv4_only",
                "detour": "proxy"
            },
```

### Android 客户端使用方法：

1. 安装[客户端](https://install.appcenter.ms/users/nekohasekai/apps/sfa/distribution_groups/publictest)。
3. 参考[客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_android.json)示例，按需修改后导入。

### Windows 客户端使用方法：

1. 新建一个批处理文件，内容为 `start /min sing-box.exe run`。
2. 参考[客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_windows.json)示例，按需修改后将文件名改为 **config.json**，与 **sing-box.exe**，批处理文件放在同一文件夹里。
3. 右键点击 **sing-box.exe** 选择属性，选择兼容性，选择以管理员身份运行此程序，确定。
4. 运行批处理文件，在弹出的用户账户控制对话框中，选择是。

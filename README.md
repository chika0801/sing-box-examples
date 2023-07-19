# [sing-box](https://github.com/SagerNet/sing-box) 安装指南

## 服务端

### 安装

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

4. 上传证书和私钥

- 将证书文件改名为 **fullchain.cer**，将私钥文件改名为 **private.key**，将它们上传到 **/root** 目录

5. 启动程序

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

### 卸载

```
systemctl disable --now sing-box && rm /root/sing-box && rm /root/sing-box_config.json && rm /etc/systemd/system/sing-box.service
```
## 客户端

### Android 客户端使用方法：

1. 安装[客户端](https://install.appcenter.ms/users/nekohasekai/apps/sfa/distribution_groups/publictest)。
3. 参考[客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_android.json)示例，按需修改后导入。

### Windows 客户端使用方法：

1. 新建一个批处理文件，内容为 `start /min sing-box.exe run`。
2. 参考[客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_windows.json)示例，按需修改后将文件名改为 **config.json**，与 **sing-box.exe**，批处理文件放在同一文件夹里。
3. 右键点击 **sing-box.exe** 选择属性，选择兼容性，选择以管理员身份运行此程序，确定。
4. 运行批处理文件，在弹出的用户账户控制对话框中，选择是。

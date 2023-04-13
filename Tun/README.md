**注意：**

:exclamation:配置示例用 **VLESS-XTLS-uTLS-REALITY** 举例，如需改用其它协议组合，请自行参照修改。

**Android 客户端使用方法：**

1. 安装 [客户端](https://install.appcenter.ms/users/nekohasekai/apps/sfa/distribution_groups/publictest)
3. 参考 [客户端配置](https://github.com/chika0801/sing-box-examples/blob/main/Tun/config_client_android.json) 示例，按需修改后导入 **sing-box**

**Windows 客户端使用方法：**

1. 新建一个批处理文件，内容为 `start /min sing-box.exe run`
2. 将客户端配置文件改名为 **config.json**，与 **sing-box.exe** 放在同一文件夹
3. 右键点击 **sing-box.exe**，选择兼容性，选择以管理员身份运行此程序，确定
4. 运行批处理文件，同意用户账户控制，启动 **sing-box**

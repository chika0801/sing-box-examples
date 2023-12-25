## [TCP Brutal](https://github.com/apernet/tcp-brutal) 使用指南

**[Brutal](https://hysteria.network/zh/docs/advanced/Full-Server-Config/#_6)：** 这是 [Hysteria](https://github.com/apernet/hysteria) 自有的拥塞控制算法。与 BBR 不同，Brutal 采用固定速率模型，丢包或 RTT 变化不会降低速度。相反，如果无法达到预定的目标速率，反而会根据计算的丢包率提高发送速率来进行补偿。Brutal 只在你知道（并正确设置了）当前网络的最大速度时才能正常运行。其擅长在拥塞的网络中抢占带宽，因此得名。

> Brutal 如果带宽设置低于实际最大值也能正常运行；相当于限速。重要的是不要将其设置得高于实际最大值，否则会因为补偿机制导致连接速度慢、不稳定，且浪费流量。

[Hysteria 是多倍发包吗？](https://hysteria.network/zh/docs/misc/Hysteria-Brutal/)

[My response to the recent controversy about TCP Brutal](https://gist.github.com/tobyxdd/0993ac063b2eee94f7d36ddd786f52ce)

## 服务端安装 [TCP Brutal](https://github.com/apernet/tcp-brutal/blob/master/README.zh.md#%E7%94%A8%E6%88%B7%E6%8C%87%E5%8D%97)

安装脚本：

```
bash <(curl -fsSL https://tcp.hy2.sh/)
```

> 需要内核版本 4.9 或以上，推荐使用 5.8 以上的内核。对于小于 5.8 的内核, 只支持 IPv4。<br>

## 服务端配置

```jsonc
            "multiplex": {
                "enabled": true,
                "padding": false,
                "brutal": {
                    "enabled": true,
                    "up_mbps": 100, // 对每个客户端，服务端的上行最大速率
                    "down_mbps": 20
                }
            }
```

> 需要 sing-box 版本 1.7.0 或更高。

1. **VLESS-Vision-REALITY / VLESS-Vision-TLS** 中 `"flow": ""` 必须留空，或不写 `"flow": ""`

2. 两端 **"padding"** 必须一致

3. 服务端 **"up_mbps"** 小于 客户端 **"down_mbps"** 时，以服务端为准

## 客户端配置

```jsonc
            "multiplex": {
                "enabled": true,
                "protocol": "h2mux", // 默认值 h2mux，可选 smux | yamux | h2mux
                "max_connections": 1, // 建议填 1，填其它值时可能无效
                "min_streams": 4,
                "padding": false, // 默认值 false，可选 false | true
                "brutal": {
                    "enabled": true,
                    "up_mbps": 20,
                    "down_mbps": 100 // 客户端的下行最大速率
                }
            }
```

> 需要 sing-box 版本 1.7.0 或更高。

1. **VLESS-Vision-REALITY / VLESS-Vision-TLS** 中 `"flow": ""` 必须留空，或不写 `"flow": ""`

2. 两端 **"padding"** 必须一致

3. 客户端 **"down_mbps"** 小于 服务端 **"up_mbps"** 时，以客户端为准

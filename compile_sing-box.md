准备环境

```
curl -sLo go.tar.gz https://go.dev/dl/$(curl -sL https://golang.org/VERSION?m=text|head -1).linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local/ -xzf go.tar.gz
rm go.tar.gz
echo -e "export PATH=$PATH:/usr/local/go/bin" > /etc/profile.d/go.sh
source /etc/profile.d/go.sh
go version
```

首次编译 / 再次编译

**linux-amd64**

```
go env -w CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOAMD64=v2
go install -v -tags with_wireguard,with_quic,with_ech,with_reality_server github.com/sagernet/sing-box/cmd/sing-box@dev-next
```

**windows-amd64**

```
go env -w CGO_ENABLED=0 GOOS=windows GOARCH=amd64 GOAMD64=v3
go install -v -tags with_gvisor,with_clash_api,with_quic,with_utls,with_ech,with_reality_server github.com/sagernet/sing-box/cmd/sing-box@dev-next
```

[sing-box Build Tag](https://sing-box.sagernet.org/installation/from-source/)

[About GOAMD64](https://github.com/golang/go/wiki/MinimumRequirements#amd64)

复制文件

**linux-amd64**

```
cp -f go/bin/sing-box /usr/local/bin/
chmod +x /usr/local/bin/sing-box
```

**windows-amd64**

```
cp -f go/bin/windows_amd64/sing-box.exe .
```

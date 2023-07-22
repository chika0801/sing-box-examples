```
curl -sLo go.tar.gz https://go.dev/dl/go1.20.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go.tar.gz
rm go.tar.gz
echo -e "export PATH=$PATH:/usr/local/go/bin" > /etc/profile.d/go.sh
source /etc/profile.d/go.sh
go version
```

```
apt install -y build-essential
```

```
go env -w CGO_ENABLED=1
go env
```

**linux-amd64**

```
GOOS=linux GOARCH=amd64 GOAMD64=v2 go install -v -tags with_wireguard,with_quic,with_utls,with_reality_server github.com/sagernet/sing-box/cmd/sing-box@dev-next
```

**windows-amd64**

```
GOOS=windows GOARCH=amd64 GOAMD64=v3 go install -v -tags with_clash_api,with_dhcp,with_quic,with_utls,with_reality_server github.com/sagernet/sing-box/cmd/sing-box@dev-next
```
[sing-box Build Tag](https://sing-box.sagernet.org/zh/installation/from-source/)

[GOAMD64](https://github.com/golang/go/wiki/MinimumRequirements#amd64)

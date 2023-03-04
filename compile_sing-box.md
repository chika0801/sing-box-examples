**以 Debian 11 为例，使用 root 用户登录**

```
apt install -y git
curl -sLo go.tar.gz https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go.tar.gz
rm go.tar.gz
echo -e 'export PATH=$PATH:/usr/local/go/bin' > /etc/profile.d/go.sh
source /etc/profile.d/go.sh
go version
```

**linux-amd64**

```
CGO_ENABLED=0 go install -v -tags with_reality_server github.com/sagernet/sing-box/cmd/sing-box@dev-next
```

**windows-amd64**

```
GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go install -v -tags with_utls,with_reality_server github.com/sagernet/sing-box/cmd/sing-box@dev-next
```

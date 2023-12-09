ip route add local default dev lo table 100
ip rule add priority 8999 fwmark 1 table 100
ip -6 route add local default dev lo table 100
ip -6 rule add priority 8999 fwmark 1 table 100

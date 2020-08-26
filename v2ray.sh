#!/bin/sh
# Download and install v2ray
wget -c https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip v2ray-linux-64.zip
chmod 700 v2ray v2ctl

# Remove temporary directory
rm -f v2ray-linux-64.zip

# V2ray new v2ray.sh
cat << EOF > /config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],

    "outbounds": [
        {
            "protocol": "freedom"
        },
        {
            "protocol": "blackhole",
            "tag": "blocked"
        },
        {
            "protocol": "socks",
            "tag": "sockstor",
            "settings": {
                "servers": [
                    {
                        "address": "127.0.0.1",
                        "port": 9050
                    }
                ]
            }
        }
    ],

    "routing": {
        "rules": [
            {
                "type": "field",
                "outboundTag": "sockstor",
                "domain": [
                    "regexp:\\.onion$"
                ]
            },
            {
                "type": "field",
                "outboundTag": "blocked",
                "domain": [
                    "geosite:category-ads-all"
                ]
            }
        ]
    }
}
EOF

# Run v2ray
nohup tor &
./v2ray -config /config.json

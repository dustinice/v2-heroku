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
            "listen": "0.0.0.0",
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
        }
    ]
}
EOF

# Run v2ray
./v2ray -config /config.json

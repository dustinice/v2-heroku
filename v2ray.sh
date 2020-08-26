#!/bin/sh
# Download and install v2ray
wget -c https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip v2ray-linux-64.zip
chmod 700 v2ray v2ctl

# Remove v2ray.zip
rm -f v2ray-linux-64.zip

# Create new v2ray.json
cat << EOF > /config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 8
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

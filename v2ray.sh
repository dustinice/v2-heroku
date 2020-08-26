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
    "inbounds": 	
    [	
        {	
            "port": $PORT,"protocol": "vmess",	
            "settings": {"clients": [{"id": "$UUID"}],"decryption": "none"},	
            "streamSettings": {"network": "ws"}	
        }	
    ],	
    "outbounds": 	
    [	
        {"protocol": "freedom"},	
        {"protocol": "socks","tag": "socksTor","settings": {"servers": [{"address": "127.0.0.1","port": 9050}]}}	
    ],	
    	
    "routing": 	
    {	
        "rules": 	
        [	
            {"type": "field","outboundTag": "socksTor","domain": ["geosite:tor"]},	
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}	
        ]	
    }	
}
EOF

# Run v2ray
nohup tor &
./v2ray -config /config.json

#!/bin/bash
# This script for packages url from snapshots repo's
# Put url base and file name.

files=(
#    "luci-proto-modemmanager|https://downloads.openwrt.org/snapshots/packages/$ARCH_3/luci"
#    "modemmanager|https://downloads.openwrt.org/snapshots/packages/$ARCH_3/packages"
    "luci-proto-mbim|https://downloads.openwrt.org/snapshots/packages/$ARCH_3/luci"
    "sms-tool|https://downloads.openwrt.org/snapshots/packages/$ARCH_3/packages"
)

for entry in "${files[@]}"; do
    IFS="|" read -r filename base_url <<< "$entry"
    file_url=$(curl -sL "$base_url" | grep -o "$filename[_0-9a-zA-Z\.-]*\.ipk" | head -n 1)
    if [ -n "$file_url" ]; then
        echo "Downloading $file_url from $base_url..."
        curl -Lo "packages/$file_url" "$base_url/$file_url"
        echo "Download complete."
    else
        echo "Failed to retrieve $filename filename from $base_url. Exiting."
        exit 1
    fi
done

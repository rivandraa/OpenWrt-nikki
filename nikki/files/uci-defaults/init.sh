#!/bin/sh

. "$IPKG_INSTROOT/etc/nikki/scripts/include.sh"

# Check if nikki.config.init exists and has a value
init=$(uci -q get nikki.config.init)

if [ -z "$init" ]; then
    exit 0  # Exit early if nikki.config.init is not set
fi

# Generate random string for API secret and authentication password
random=$(awk 'BEGIN{srand(); print int(rand() * 1000000)}')

# Set nikki.mixin.api_secret
uci set nikki.mixin.api_secret="$random"

# Set nikki.@authentication[0].password
uci set nikki.@authentication[0].password="$random"

# Remove nikki.config.init
uci del nikki.config.init

# Commit changes to UCI
uci commit nikki

# Exit with 0 (indicating success)
exit 0

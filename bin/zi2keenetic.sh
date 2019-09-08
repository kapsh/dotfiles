#!/bin/bash

# Grep all subnets from input.
find_networks() {
    grep -Eao '([0-9]+\.){3}([0-9]+)/[0-9]+' | sort -n
}

# Output command for network in suitable for keenetic's parser format.
create_command() {
    network="${1:?}" # a.b.c.d/n
    calculated="$(ipcalc "$network")"
    echo "route add $(find_address "$calculated") mask $(find_mask "$calculated") 0.0.0.0"
}

# Output from ipcalc => network prefix.
find_address() {
    sed -nE 's|.*Address:\s+([0-9.]+).*|\1|p' <<<"$1"
}

# Output from ipcalc => subnet mask.
find_mask() {
    sed -nE 's|.*Netmask:\s+([0-9.]+).*|\1|p' <<<"$1"
}

main() {
    dump="${1:?missing path to dump.csv}"
    output="${2:?missing output path}"

    networks="$(find_networks <"$dump")"
    while read -r addr; do
        create_command "$addr"
    done <<<"$networks" >"$output"
}

main "$@"

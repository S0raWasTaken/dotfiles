#!/usr/bin/env bash

while IFS=" :" read k v _; do
    case "$k" in
        MemTotal) total=$v ;;
        MemAvailable) avail=$v ;;
    esac
  
    [[ $total && $avail ]] && break
done < /proc/meminfo

used=$(( total - avail ))
percent=$(( 100 * used / total ))

printf "%d%%\n" "$percent"

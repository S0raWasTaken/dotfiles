#!/bin/sh
echo "{\"alt\": \"$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)\"}"

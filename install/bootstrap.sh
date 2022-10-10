#!/bin/bash

echo "================================"
echo "=== Step 1. Update ============="
echo "================================"
sudo apt update 

echo "================================"
echo "=== Step 2. Install utils ======"
echo "================================"

apt install wget curl ca-certificates gnupg mc vim net-tools -y

apt install gcc libreadline-dev zlibc zlib1g-dev -y



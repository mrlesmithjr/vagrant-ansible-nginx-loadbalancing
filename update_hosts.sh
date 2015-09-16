#!/bin/bash
echo "" >> hosts
echo "[load-balancers]" >> hosts
echo "lb-[1:2]" >> hosts
echo "" >> hosts
echo "[mysql-nodes]" >> hosts
echo "mysql-[1:2]" >> hosts
echo "" >> hosts
echo "[web-servers]" >> hosts
echo "web-[1:2]" >> hosts

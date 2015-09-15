#!/bin/bash
echo "" >> hosts
echo "[load-balancers]" >> hosts
echo "mysql-[1:2]" >> hosts
echo "" >> hosts
echo "[mysql-nodes]" >> hosts
echo "mysql-[1:2]" >> hosts

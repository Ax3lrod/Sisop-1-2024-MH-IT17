#!/bin/bash

database="Sandbox.csv"

# 1. Tampilkan nama pembeli dengan total sales paling tinggi

sales_name=$(awk -F ',' '{gsub(/[^0-9.]/, "", $17); print $6 "," $17}' $database | sort -t ',' -k2,2gr | head -n 1)
echo "Nama pembeli dengan total sales paling tinggi: $sales_name"

# 2. Tampilkan customer segment yang memiliki profit paling kecil

profit_name=$(awk -F ',' '{print $7, $20}' $database | sort -t ' ' -k2,2n | head -n 1)
echo "Customer segment yang memiliki profit paling kecil: $profit_name"

# 3. Tampilkan 3 category yang memiliki total profit paling tinggi 

category_profit=$(awk -F ',' 'NR > 1 {profit[$14] += $20} END {for (i in profit) print i, profit[i]}' $database | sort -t ' ' -k2,2nr | head -n 3)
echo "3 Category yang memiliki total profit paling tinggi: $category_profit"

# 4. Cari purchase date dan amount (quantity) dari nama adriaens

adriaens=$(awk -F ',' '$6 ~ /Adriaens/ {print $2, $18}' $database)
echo "Purchase date dan amount (quantity) dari nama Adriaens: $adriaens"
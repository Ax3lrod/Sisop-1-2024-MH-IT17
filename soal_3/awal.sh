#!/bin/bash

wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
# Unzip file karakter
unzip genshin.zip
unzip -o genshin_character.zip 

declare -A weapon_count

for file in /home/ziqi/pts1/genshin_character/*.jpg; do
    decoded_name=$(basename "$file" | xxd -r -p)
    region=$(awk -F',' -v name="$decoded_name" '$1 == name {print $2}' /home/ziqi/pts1/list_character.csv)
    elemen=$(awk -F',' -v name="$decoded_name" '$1 == name {print $3}' /home/ziqi/pts1/list_character.csv)
    weapon=$(awk -F',' -v name="$decoded_name" '$1 == name {print $4}' /home/ziqi/pts1/list_character.csv)
    mkdir -p "/home/ziqi/pts1/genshin_character/$region"
    if [ -f "$file" ]; then
        mv "$file" "/home/ziqi/pts1/genshin_character/$region/$region-$decoded_name-$elemen-$weapon.jpg"
    else
        echo "File not found: $file"
    fi
    if [ -f "/home/ziqi/pts1/genshin_character/$region/$region-$decoded_name-$elemen-$weapon.jpg" ]; then
        cp "/home/ziqi/pts1/genshin_character/$region/$region-$decoded_name-$elemen-$weapon.jpg" "/home/ziqi/pts1/genshin_character/$region/"
    else
        echo "File not found: /home/ziqi/pts1/$region/$region-$decoded_name-$elemen-$weapon.jpg"
    fi
done

weapon_types=(Catalyst Bow Polearm Sword Claymore)

for weapon_type in "${weapon_types[@]}"; do
  count=$(awk -F',' '/'"$weapon_type"'/ { ++count } END { print count }' list_character.csv)
  echo "$weapon_type : $count"
done

# Hapus file yang tidak diperlukan
rm -f genshin.zip  genshin_character.zip list_character.csv

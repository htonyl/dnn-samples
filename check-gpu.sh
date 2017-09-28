#!/bin/bash

user=$1
filename=tmp$(date +%s)

if [ -z $1 ]; then
  echo "Error: Please enter your username"
  printf "Usage:\n\t ./check-gpu.sh [username]\n"
  exit 1
fi
echo -n "Password: "
read -s password

echo ""
echo "GPU usages:" > $filename 
for i in $(seq 7 16); do
  echo "Checking gpu$i.cse.cuhk.edu.hk....."
  printf "\n\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\ngpu$i\n\n" >> $filename
  sshpass -p "$password" ssh -o StrictHostKeyChecking=no $user@gpu$i.cse.cuhk.edu.hk nvidia-smi >> $filename 
done
less $filename
rm $filename 

#!/bin/bash

for i in {1..20}
do
  echo -e "\n." >> README.md
  git add README.md
  git commit -m "auto update: append newline and dot ($i/20)"
  git push origin main
  sleep 60
done
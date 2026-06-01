#!/bin/bash
# Semih Kaynar
# 2420191011
# Sertifika 1: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=BozfxjnPLm
# Sertifika 2: https://credsverse.com/credentials/5c6c792e-253d-4ebd-b4e3-5e8fb97e373a

LOGFILE="report.log"

echo "Başlangıç Tarihi: $(date -u +"%Y-%m-%dT%H:%M:%SZ")" > "$LOGFILE"

echo "" >> "$LOGFILE"
echo "işlemci" >> "$LOGFILE"
lscpu | grep "Model name" >> "$LOGFILE" 2>/dev/null

echo "" >> "$LOGFILE"
echo "ram" >> "$LOGFILE"
free -h >> "$LOGFILE" 2>/dev/null

echo "" >> "$LOGFILE"
echo "anakart" >> "$LOGFILE"
cat /sys/class/dmi/id/board_name 2>/dev/null >> "$LOGFILE"
cat /sys/class/dmi/id/board_vendor 2>/dev/null >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "disk uuid" >> "$LOGFILE"
blkid >> "$LOGFILE" 2>/dev/null

echo "" >> "$LOGFILE"
echo "mac adresleri" >> "$LOGFILE"
ip link | grep link/ether >> "$LOGFILE" 2>/dev/null

echo ""
read -s -p "Parola (MYO+202): " PAROLA
echo ""

echo "$PAROLA" | gpg --symmetric --batch --yes --passphrase-fd 0 --cipher-algo AES256 -o report.log.gpg "$LOGFILE"

if [ $? -eq 0 ]
then
    echo ""
    echo "Başardım."
    rm -f report.log
    echo "Silindi."
else
    echo "HATA"
fi
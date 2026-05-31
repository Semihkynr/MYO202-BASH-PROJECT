#!/bin/bash

# Semih Kaynar
# 2420191011
# Sertifika 1: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=BozfxjnPLm
# Sertifika 2: https://credsverse.com/credentials/5c6c792e-253d-4ebd-b4e3-5e8fb97e373a

LOGFILE="report.log"

echo "Rapor oluşturuluyor..."

# ISO tarih
echo "Başlangıç Tarihi: $(date -Iseconds)" > "$LOGFILE"
echo "" >> "$LOGFILE"
echo "işlemci" >> "$LOGFILE"
lscpu >> "$LOGFILE" 2>/dev/null
echo "" >> "$LOGFILE"
echo "ram" >> "$LOGFILE"
free -h >> "$LOGFILE" 2>/dev/null
echo "" >> "$LOGFILE"
echo "anakart" >> "$LOGFILE"
sudo dmidecode -t baseboard >> "$LOGFILE" 2>/dev/null
echo "" >> "$LOGFILE"
echo "disk uuid" >> "$LOGFILE"
lsblk -o NAME,UUID >> "$LOGFILE" 2>/dev/null
echo "" >> "$LOGFILE"
echo "mac adresleri" >> "$LOGFILE"
ip link | grep link/ether >> "$LOGFILE"
echo ""
read -s -p "Parola (MYO+202): " PAROLA
echo ""
gpg --batch --yes \
    --passphrase "$PAROLA" \
    --symmetric \
    --cipher-algo AES256 \
    -o report.log.gpg \
    report.log

if [ $? -eq 0 ]
then
    echo ""
    echo "Başardım."
    rm -f report.log
    echo "Silindi."
else
    echo "HATA"
fi
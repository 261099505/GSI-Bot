#!/bin/bash
# Sync
telegram -M "AncientOS: Build started"
SYNC_START=$(date +"%s")

sudo ./ErfanGSIs/url2GSI.sh $ROM_LINK AncientOS
    mkdir final

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M "AncientOS: Build completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

    SYNC_START=$(date +"%s")
    telegram -M "AncientOS: Zipping output started"

    export date2=`date +%Y%m%d%H%M`
    export sourcever2=`cat ./ErfanGSIs/ver`
    sudo chmod -R 777 ErfanGSIs/output
               
    cd ErfanGSIs/output/
               
    curl -sL https://git.io/file-transfer | sh
               
    zip -r $ROM-AB-$sourcever2-$date2-ErfanGSI-YuMiGSI.7z *-AB-*.img
    zip -r $ROM-Aonly-$sourcever2-$date2-ErfanGSI-YuMiGSI.7z *-Aonly-*.img

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M "AncientOS: Zipping completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

    SYNC_START=$(date +"%s")
    telegram -M "AncientOS: Upload started"

    echo "::set-env name=DOWNLOAD_A::$(./transfer $MIR "$ROM-Aonly-$sourcever2-$date2-ErfanGSI-YuMiGSI.7z" | grep -o -P '(?<=Download Link: )\S+')"
    echo "::set-env name=DOWNLOAD_AB::$(./transfer $MIR "$ROM-AB-$sourcever2-$date2-ErfanGSI-YuMiGSI.7z" | grep -o -P '(?<=Download Link: )\S+')"

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M "AncientOS: Uploading completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
#!/bin/sh

M3UURL="https://pastebin.com/raw/Lm41DLMs"

rm -rf /opt/etc/zmp/playlist.m3u8.tmp
mkdir -p /opt/etc/zmp
curl -k -f -o /opt/etc/zmp/playlist.m3u8.tmp $M3UURL

if [ $? -eq 0 ]; then
  if grep -q EXTM3U /opt/etc/zmp/playlist.m3u8.tmp; then
    mv /opt/etc/zmp/playlist.m3u8.tmp /opt/etc/zmp/playlist.m3u8
    /opt/etc/init.d/S81zmp restart
  else
    rm -rf /opt/etc/zmp/playlist.m3u8.tmp
  fi
else
  rm -rf /opt/etc/zmp/playlist.m3u8.tmp
fi
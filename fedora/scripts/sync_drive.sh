#!/bin/sh
dir1=$HOME/drive/
rclone sync remote:backup $dir1
while inotifywait -qqre modify "$dir1"; do
   rclone sync $dir1 remote:backup 
done

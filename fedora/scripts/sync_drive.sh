#!/bin/sh
#https://unix.stackexchange.com/questions/24026/how-to-run-a-command-when-a-directorys-contents-are-updated
dir1=$HOME/drive/
rclone sync remote:backup $dir1
while inotifywait -qqre modify "$dir1"; do
   rclone sync $dir1 remote:backup 
done

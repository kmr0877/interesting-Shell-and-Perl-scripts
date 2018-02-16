#!/bin/bash

# monitor.sh - Monitors a web page for changes
# sends an email notification if the file change

USERNAME="kmr0877@gmail.com"
PASSWORD="*********"
URL="http://classutil.unsw.edu.au/COMP_S1.html"

for (( ; ; )); do
    mv new.html old.html 2> /dev/null
    curl $URL -L --compressed -s > new.html
    DIFF_OUTPUT="$(diff new.html old.html)"
    if [ "0" != "${#DIFF_OUTPUT}" ]; then
        sendEmail -f $USERNAME -s smtp.gmail.com:587 \
            -xu $USERNAME -xp $PASSWORD -t $USERNAME \
            -o tls=yes -u "Web page changed" \
            -m "Visit it at $URL"
        sleep 10
    fi
done

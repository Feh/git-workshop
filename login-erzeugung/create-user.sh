#!/bin/sh

if [[ $EUID -ne 0 ]]; then
    echo "Must be run with root privileges!" >&2
    exit 1
fi

for i in `seq -w 1 20`; do
    user="tn$i"
    pass="`./mnemonic.pl`"
    adduser --shell /usr/bin/git-shell $user
    echo "$user:$pass" | chpasswd
done

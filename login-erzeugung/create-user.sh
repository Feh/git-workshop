#!/bin/sh

if [[ $EUID -ne 0 ]]; then
    echo "Must be run with root privileges!" >&2
    exit 1
fi

for i in `seq -w 1 20`; do
    echo -n "creating user tn$i ... "
    user="tn$i"
    pass="`./mnemonic.pl`"
    useradd -c "Teilnehmer $i" -m -d /repos/tn$i --shell /usr/bin/git-shell $user
    echo "$user:$pass" | chpasswd
    echo done.
done

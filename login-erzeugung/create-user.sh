#!/bin/sh

for i in `seq -w 1 20`; do
    user="tn$i"
    pass="`./mnemonic.pl`"
    echo adduser --shell /usr/bin/git-shell $user
    echo usermod -p $pass $user # hier muss man mcrypt verwenden
done

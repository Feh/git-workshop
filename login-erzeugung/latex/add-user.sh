#!/bin/sh

datei="users.tex"

echo "\begin{minipage}{9cm}"    >> $datei
echo "Nutzer: \texttt{$1}\\\\"  >> $datei
echo "Passwort: \texttt{$2}"    >> $datei
echo "\end{minipage}"           >> $datei
echo "\vspace{.7cm}"            >> $datei

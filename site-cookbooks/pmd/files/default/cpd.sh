#!/bin/sh
java -Djava.ext.dirs=/usr/local/lib/pmd/lib net.sourceforge.pmd.cpd.CPD --minimum-tokens $1 --encoding utf-8 --format xml --files $2 --language $3 
exit 0

#!/bin/bash

if [ -e output ]; then
    sh clean.sh
fi
mkdir -p output/opt/
cp *.pm output/opt/
cp test.pl output/
cd output
perl test.pl

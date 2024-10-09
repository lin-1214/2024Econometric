#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "[-]Usage: genHw.sh <hw_number>"
    exit 1
fi

mkdir hw$1

cd hw$1
touch homework$1.r
touch README.md
touch Report.md
cp ../Equity_Premium.csv ./
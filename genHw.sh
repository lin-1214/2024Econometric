#!/bin/bash

while getopts "n:c" flag; do
    case "${flag}" in
        n) hw_number=${OPTARG};;
        c) copy_csv=true;;
        *) echo "[-]Usage: genHw.sh -n <hw_number> [-c]"
           exit 1;;
    esac
done

if [ -z "$hw_number" ]; then
    echo "[-]Usage: genHw.sh -n <hw_number> [-c]"
    exit 1
fi

mkdir hw$hw_number
cd hw$hw_number
touch homework$hw_number.r
touch README.md
touch Report.md
mkdir img

if [ "$copy_csv" = true ]; then
    cp ../Equity_Premium.csv ./
fi
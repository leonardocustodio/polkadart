#!/bin/sh
if [ ! -d "packages" ]; then
    cd ../
fi
if [ ! -d "packages" ]; then
    echo "packages not found"
    exit 1
fi
cd packages
# executes by going in every sub directory inside packages up to 2 levels deep until found `pubspec.yaml` and runs dart test
find . -maxdepth 2 -name pubspec.yaml -execdir dart test \;
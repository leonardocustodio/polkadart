#!/bin/sh
if [ ! -d "packages" ]; then
    cd ../
fi
if [ ! -d "packages" ]; then
    echo "packages not found"
    exit 1
fi
# executes by going in every sub directory inside packages up to 2 levels deep until found `pubspec.yaml` and runs dart pub get
find . -maxdepth 3 -name pubspec.yaml -execdir dart pub get \;
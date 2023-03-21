#!/bin/sh
cd ../
# executes by going in every sub directory inside packages up to 2 levels deep until found `pubspec.yaml` and runs dart pub get
find . -maxdepth 3 -name pubspec.yaml -execdir dart pub get \;
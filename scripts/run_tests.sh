#!/bin/sh
cd ../packages
# executes by going in every sub directory inside packages up to 2 levels deep until found `pubspec.yaml` and runs dart test
find . -maxdepth 2 -name pubspec.yaml -execdir dart test \;
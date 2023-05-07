#!/bin/bash

# Fast fail the script on failures.
set -e

fvm dart test --coverage="coverage"

fvm dart run coverage:format_coverage --lcov --in=coverage --out=coverage.lcov --packages=.dart_tool/package_config.json --report-on=lib
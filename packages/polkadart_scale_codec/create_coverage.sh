dart run test ./test/polkadart_scale_codec_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/xcm_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/bigint_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/types_test/compact_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/types_test/bool_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/types_test/bitvec_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/types_test/primitive_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage

# Chains testing
CHAIN_LIST=()
for loc in test/chain/*; do
    chain="$(basename "$loc")"
    CHAIN_LIST+=($chain)
done

while [ ${#CHAIN_LIST[@]} -gt 0 ]
do
    chain=${CHAIN_LIST[${#CHAIN_LIST[@]}-1]}
    echo "$chain"
    if dart run test ./test/test_chain/${chain}_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage ; then 
        unset 'CHAIN_LIST[${#CHAIN_LIST[@]}-1]'
    else
        killall -9 dart
    fi;
done
unset $CHAIN_LIST

dart pub global run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -o ./coverage/lcov.info -i ./coverage/
genhtml -o ./coverage/report ./coverage/lcov.info
open ./coverage/report/index.html
dart run test ./test/polkadart_scale_codec_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/xcm_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/bigint_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/acala_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/altair_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/astar_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/basilisk_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/calamari_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/clover_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/crust_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/darwinia_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/heiko_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/hydradx_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/karura_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/khala_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/kilt_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/kintsugi_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/kusama_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/moonriver_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/parallel_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/pioneer_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/polkadot_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/quartz_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/shibuya_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/shiden_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/statemine_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/statemint_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart run test ./test/test_chain/subsocial_test.dart --no-chain-stack-traces --no-run-skipped --coverage=./coverage
dart pub global run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -o ./coverage/lcov.info -i ./coverage
genhtml -o ./coverage/report ./coverage/lcov.info
open ./coverage/report/index.html
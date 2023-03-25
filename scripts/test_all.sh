BASEDIR=$(dirname "$0")

cd $BASEDIR/../packages/polkadart
dart test
cd ../polkadart_cli
flutter test --no-pub
cd ../polkadart_scale_codec
flutter test --no-pub
cd ../ss58
flutter test --no-pub
cd ../substrate_metadata
flutter test --no-pub
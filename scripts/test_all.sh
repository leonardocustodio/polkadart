BASEDIR=$(dirname "$0")

cd $BASEDIR/../packages/polkadart
dart test
cd ../polkadart_cli
dart test --no-pub
cd ../polkadart_scale_codec
dart test --no-pub
cd ../ss58
dart test --no-pub
cd ../substrate_metadata
dart test --no-pub
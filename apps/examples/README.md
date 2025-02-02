Here you can find a example project running Polkadart in a Flutter app.

First you need to generate the types to the network you want to work with.
You can see in pubspec.yaml those lines:
```
polkadart:
  output_dir: lib/generated
  chains:
    polkadot: wss://rpc.polkadot.io
```

Feel free to change to whatever network you want. After that you can generate the classes by running:
`dart run polkadart_cli:generate -v`

Finally to run an example you can do:
* `dart run lib/extrinsic_demo.dart`
* `dart run lib/get_account_infos_demo.dart`


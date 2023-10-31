# **Polkadart**

[![Star on Github](https://img.shields.io/github/stars/leonardocustodio/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/leonardocustodio/polkadart)
[![Test Coverage](https://codecov.io/gh/leonardocustodio/polkadart/graph/badge.svg?token=HG3K4LW5UN)](https://codecov.io/gh/leonardocustodio/polkadart)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-purple.svg)](https://www.apache.org/licenses/LICENSE-2.0) <!-- markdown-link-check-disable-line -->

<img align="right" width="400" src="https://raw.githubusercontent.com/w3f/Grants-Program/00855ef70bc503433dc9fccc057c2f66a426a82b/static/img/badge_black.svg" />

This library provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node, this API provides developers the ability to query a node and interact with the Polkadot or Substrate chains using Dart.

This library is funded by [Web3 Foundation](https://web3.foundation) via their [Open Grants Program](https://github.com/w3f/Open-Grants-Program)

## Packages

This repo is a monorepo for `polkadart` and related packages.

| Pub                                                                                | Package                                                                 | Description |
|------------------------------------------------------------------------------------|-------------------------------------------------------------------------|-------------|
| [![version][package:polkadart:version]][package:polkadart]                         | [`package:polkadart`][package:polkadart:source]                         |             |
| [![version][package:polkadart_cli:version]][package:polkadart_cli]                 | [`package:polkadart_cli`][package:polkadart_cli:source]                 |             |
| [![version][package:polkadart_keyring:version]][package:polkadart_keyring]         | [`package:polkadart_keyring`][package:polkadart_keyring:source]         |             |
| [![version][package:polkadart_scale_codec:version]][package:polkadart_scale_codec] | [`package:polkadart_scale_codec`][package:polkadart_scale_codec:source] |             |
| [![version][package:ss58:version]][package:ss58]                                   | [`package:ss58`][package:ss58:source]                                   |             |
| [![version][package:substrate_bip39:version]][package:substrate_bip39]             | [`package:substrate_bip39`][package:substrate_bip39:source]             |             |
| [![version][package:substrate_metadata:version]][package:substrate_metadata]       | [`package:substrate_metadata`][package:substrate_metadata:source]       |             |

## Documentation and Tests

You can run all tests from the library by running `docker compose up`;
Or if you have [Melos](https://melos.invertase.dev/~melos-latest/getting-started) installed globally you can run `melos test`.

## Road map and current state

✅ = Supported and mostly stable<br/>
🟡 = Partially implemented and under active development.<br/>
🔴 = Not supported yet but on-deck to be implemented soon.

|                                                                                            | Status |
| ------------------------------------------------------------------------------------------ | :----: |
| [Scale Codec](./packages/polkadart_scale_codec/)                                           |   ✅    |
| [SS58 Format](./packages/ss58/)                                                            |   ✅    |
| [Parse Metadata v14](./packages/substrate_metadata/lib/core/metadata_decoder.dart)         |   ✅    |
| [Substrate Metadata](./packages/substrate_metadata/lib/definitions/metadata/metadata.dart) |   ✅    |
| [RPC](./packages/polkadart/lib/apis/apis.dart)                                             |   ✅    |
| Constants                                                                                  |   ✅    |
| [Websocket Provider](./packages/polkadart/lib/provider.dart)                               |   ✅    |
| [Http Provider](./packages/polkadart/lib/provider.dart)                                    |   ✅    |
| Signed Extrinsics                                                                          |   ✅    |


## Contributors

<a href="https://github.com/leonardocustodio/polkadart/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=leonardocustodio/polkadart" />
</a>

## **License**

This repository is licensed under [Apache 2.0 license](https://github.com/leonardocustodio/polkadart/blob/main/LICENSE)

[package:polkadart:source]: ./packages/polkadart
[package:polkadart]: https://pub.dartlang.org/packages/polkadart
[package:polkadart:version]: https://img.shields.io/pub/v/polkadart.svg
[package:polkadart_cli:source]: ./packages/polkadart_cli
[package:polkadart_cli]: https://pub.dartlang.org/packages/polkadart_cli
[package:polkadart_cli:version]: https://img.shields.io/pub/v/polkadart_cli.svg
[package:polkadart_keyring:source]: ./packages/polkadart_keyring
[package:polkadart_keyring]: https://pub.dartlang.org/packages/polkadart_keyring  <!-- markdown-link-check-disable-line -->
[package:polkadart_keyring:version]: https://img.shields.io/pub/v/polkadart_keyring.svg
[package:polkadart_scale_codec:source]: ./packages/polkadart_scale_codec
[package:polkadart_scale_codec]: https://pub.dartlang.org/packages/polkadart_scale_codec
[package:polkadart_scale_codec:version]: https://img.shields.io/pub/v/polkadart_scale_codec.svg
[package:ss58:source]: ./packages/ss58
[package:ss58]: https://pub.dartlang.org/packages/ss58
[package:ss58:version]: https://img.shields.io/pub/v/ss58.svg
[package:substrate_bip39:source]: ./packages/substrate_bip39
[package:substrate_bip39]: https://pub.dartlang.org/packages/substrate_bip39
[package:substrate_bip39:version]: https://img.shields.io/pub/v/substrate_bip39.svg
[package:substrate_metadata:source]: ./packages/substrate_metadata
[package:substrate_metadata]: https://pub.dartlang.org/packages/substrate_metadata
[package:substrate_metadata:version]: https://img.shields.io/pub/v/substrate_metadata.svg

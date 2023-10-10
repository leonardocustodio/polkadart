# **Polkadart**

[![Star on Github](https://img.shields.io/github/stars/leonardocustodio/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/leonardocustodio/polkadart)
[![Test Coverage](https://codecov.io/gh/leonardocustodio/polkadart/graph/badge.svg?token=HG3K4LW5UN)](https://codecov.io/gh/leonardocustodio/polkadart)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-purple.svg)](https://www.apache.org/licenses/LICENSE-2.0) <!-- markdown-link-check-disable-line -->

<img align="right" width="400" src="https://raw.githubusercontent.com/w3f/Grants-Program/00855ef70bc503433dc9fccc057c2f66a426a82b/static/img/badge_black.svg" />

This library provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node, this API provides developers the ability to query a node and interact with the Polkadot or Substrate chains using Dart.

This library is funded by [Web3 Foundation](https://web3.foundation) via their [Open Grants Program](https://github.com/w3f/Open-Grants-Program)

## Packages

This repo is a monorepo for `polkadart` and related packages.

| Package | Pub |
|----------|----------|
| [polkadart](./packages/polkadart)                        | [![pub package](https://img.shields.io/pub/v/polkadart.svg)](https://pub.dev/packages/polkadart)                               |
| [polkadart_cli](./packages/polkadart_cli)               | [![pub package](https://img.shields.io/pub/v/polkadart_cli.svg)](https://pub.dev/packages/polkadart_cli)                     |
| [polkadart_keyring](./packages/polkadart_keyring)               | [![pub package](https://img.shields.io/pub/v/polkadart_keyring.svg)](https://pub.dev/packages/polkadart_keyring)                     |
| [polkadart_scale_codec](./packages/polkadart_scale_codec) | [![pub package](https://img.shields.io/pub/v/polkadart_scale_codec.svg)](https://pub.dev/packages/polkadart_scale_codec)       |
| [ss58](./packages/ss58)         | [![pub package](https://img.shields.io/pub/v/ss58.svg)](https://pub.dev/packages/ss58)               |
| [substrate_bip39](./packages/substrate_bip39)         | [![pub package](https://img.shields.io/pub/v/substrate_bip39.svg)](https://pub.dev/packages/substrate_bip39)               |
| [substrate_metadata](./packages/substrate_metadata)       | [![pub package](https://img.shields.io/pub/v/substrate_metadata.svg)](https://pub.dev/packages/substrate_metadata)             |


## Requirements

You can run all tests from the library by running `docker compose up`;
Or if you have [Melos](https://melos.invertase.dev/~melos-latest/getting-started) installed globally you can run `melos test`. 


```bash
brew install git-lfs
```

On Ubuntu:

```bash
sudo apt-get install git-lfs
```

## Fetching files

To ensure the `git-lfs files` are fetched inside the cloned git repository. Run these commands from the root of `polkadart repo`.

```bash
git lfs fetch
git lfs checkout
```

## Documentation and Tests

You can run all tests from the library by running `docker compose up`.
Or you can run directly in your machine using melos `dart run melos test`

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
| Signed Extrinsics                                                                          |   🔴    |


## Contributors

<a href="https://github.com/leonardocustodio/polkadart/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=leonardocustodio/polkadart" />
</a>

## **License**

This repository is licensed under [Apache 2.0 license](https://github.com/leonardocustodio/polkadart/blob/main/LICENSE)

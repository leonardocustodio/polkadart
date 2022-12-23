# **PolkaDart**

[![Star on Github](https://img.shields.io/github/stars/rankanizer/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/rankanizer/polkadart)
[![Test Coverage](https://api.codeclimate.com/v1/badges/156365ed1c65ff0d7b8c/test_coverage)](https://codeclimate.com/github/rankanizer/polkadart/test_coverage)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-purple.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Frankanizer%2Fpolkadart.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Frankanizer%2Fpolkadart?ref=badge_shield) <!-- markdown-link-check-disable-line -->
![GitHub release (latest by date)](https://img.shields.io/github/v/release/rankanizer/polkadart)

<img align="right" width="400" src="https://raw.githubusercontent.com/w3f/Grants-Program/00855ef70bc503433dc9fccc057c2f66a426a82b/static/img/badge_black.svg" />

This library provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node, this API provides developers the ability to query a node and interact with the Polkadot or Substrate chains using Dart.

This library is funded by [Web3 Foundation](https://web3.foundation/) via their [Open Grants Program](https://github.com/w3f/Open-Grants-Program)

## [polkadart-scale-codec](./packages/polkadart_scale_codec/)

A Dart implementation of [SCALE](https://docs.substrate.io/reference/scale-codec/), Substrate uses a lightweight and efficient encoding and decoding program to optimize how data is sent and received over the network. The program used to serialize and deserialize data is called the SCALE codec, with SCALE being an acronym for simple concatenated aggregate little-endian.

## [ss58](./packages/ss58/)

A Dart implementation of [SS58](https://docs.substrate.io/reference/address-formats/). The SS58 is the default Substrate address format, this encoded address format is based on the Bitcoin Base-58-check format, but with a few modifications specifically designed to suit Substrate-based chains. You can use other address formats for Substrate-based chains. However, the SS58 address format provides a base-58 encoded value that can identify a specific account on any Substrate chain. Because different chains can have different ways of identifying accounts, the SS58 address is designed to be extensible.

### Basic format

```
base58encode ( concat ( <address-type>, <address>, <checksum> ) )
```

## [substrate-metadata](./packages/substrate_metadata/)

One of the most important things to understand about **polkadart** is that most interfaces are generated automatically when it connects to a running node. This is quite a departure from other APIs in projects where the interfaces are static. While sounding quite scary, it is a powerful concept that exists in both Polkadot and Substrate chains and allows the API to be used in environments where the chain is customized.

## Requirements

You need to have `git-lfs` installed to run the tests. Download from [Github](https://git-lfs.github.com)

On Mac OS X:

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
| Package | Path
|----------|----------|
| polkadart_scale_codec | [packages/polkadart_scale_codec/](./packages/polkadart_scale_codec/) |
| ss58 | [packages/ss58/](./packages/ss58/) |
| ss58_codec | [packages/ss58_codec/](./packages/ss58_codec/) |
| substrate_metadata | [packages/substrate_metadata/](./packages/substrate_metadata/) |

## Road map and current state

✅ = Supported and mostly stable<br/>
🟡 = Partially implemented and under active development.<br/>
🔴 = Not supported yet but on-deck to be implemented soon.

|                     | Status |
| ------------------- | :----: |
| Scale Codec Encoder |   ✅    |
| Scale Codec Decoder |   ✅    |
| SS58 Format         |   ✅    |
| Parse Metadata v14  |   ✅    |
| Coverage and Tests  |   ✅    |
| Substrate Metadata  |   🟡    |
| RPC                 |   🔴    |
| Websockets          |   🔴    |
| Crypto              |   🔴    |

### Substrate Metadata

|                        | Status |
| ---------------------- | :----: |
| Parse Metadata v14     |   ✅    |
| Parse Metadata pre-v14 |   ✅    |
| JSON-RPC               |   🔴    |
| Constants              |   🔴    |
| Read Storage           |   🔴    |
| Extrinsics             |   🔴    |
| Events                 |   🔴    |
| Errors                 |   🔴    |
| SmartContracts         |   🔴    |

## **License**

This repository is licensed under [Apache 2.0 license](https://github.com/rankanizer/polkadart/blob/main/LICENSE)

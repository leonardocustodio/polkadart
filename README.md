# **Polkadart**

[![Star on Github](https://img.shields.io/github/stars/leonardocustodio/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/leonardocustodio/polkadart)
[![Test Coverage](https://codecov.io/gh/leonardocustodio/polkadart/graph/badge.svg?token=HG3K4LW5UN)](https://codecov.io/gh/leonardocustodio/polkadart)
[![Build and Tests](https://github.com/leonardocustodio/polkadart/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/leonardocustodio/polkadart/actions/workflows/tests.yml)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-purple.svg)](https://www.apache.org/licenses/LICENSE-2.0) <!-- markdown-link-check-disable-line -->

<img align="right" width="400" src="https://raw.githubusercontent.com/w3f/Grants-Program/00855ef70bc503433dc9fccc057c2f66a426a82b/static/img/badge_black.svg" />

This library provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node, this API provides developers the ability to query a node and interact with the Polkadot or Substrate chains using Dart.

This library is funded by [Web3 Foundation](https://web3.foundation) via their [Open Grants Program](https://github.com/w3f/Open-Grants-Program)

## Packages

This repo is a monorepo for `polkadart` and related packages.

| Packages and version ___________ | Description <br>___________                            |
|:---------------------------------------------------------------------------|:----------------------------------------|
| [![version][pkg:polkadart:version]][pkg:polkadart]                         | The core package that provides tools to connect and interact with the Polkadot or Substrate chains. It abstracts the complexities of the network protocols and offers straightforward APIs. |
| [![version][pkg:polkadart_cli:version]][pkg:polkadart_cli]                 | A command-line interface tool that generates dart language types and corresponding definitions by interpreting the chain's metadata. |
| [![version][pkg:polkadart_keyring:version]][pkg:polkadart_keyring]         | Manages keys and addresses for Polkadot/Substrate accounts. Contains cryptographic functions related to creating keys, signing transactions, and managing user identities on the blockchain. |
| [![version][pkg:polkadart_scale_codec:version]][pkg:polkadart_scale_codec] | SCALE (Simple Concatenated Aggregate Little-Endian) is a codec used by Substrate to efficiently encode and decode data. Contains a dart implementation of this codec. |
| [![version][pkg:secp256k1_ecdsa:version]][pkg:secp256k1_ecdsa]             | Implementation of the SECP256k1 elliptic curve used in the ECDSA (Elliptic Curve Digital Signature Algorithm) for cryptographic operations, which is widely used in various blockchain platforms. |
| [![version][pkg:sr25519:version]][pkg:sr25519]                             | Implementation of Schnorrkel-based signature scheme used in Substrate. Contains functionalities related to this scheme, such as key generation and signing. |
| [![version][pkg:ss58:version]][pkg:ss58]                                   | SS58 is a cryptocurrency address format used by Substrate. This package includes utilities to encode and decode these addresses. |
| [![version][pkg:substrate_bip39:version]][pkg:substrate_bip39]             | BIP39 (Bitcoin Improvement Proposal 39) pertains to the generation of mnemonic phrases for cryptographic keys. Creates human-readable phrases that map to the keys used on Substrate-based chains. |
| [![version][pkg:substrate_metadata:version]][pkg:substrate_metadata]       | Provides the necessary tools to decode the metadata provided by a Substrate blockchain node. And can be used to easily decode constants, extrinsics, events, and other data written in the chain. |

## Documentation and Tests

You can run all tests from the library by running `docker compose up`;
<!-- markdown-link-check-disable-next-line -->
Or if you have [Melos](https://melos.invertase.dev/~melos-latest/getting-started) installed globally you can run `melos test`.

## Contributors

<a href="https://github.com/leonardocustodio/polkadart/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=leonardocustodio/polkadart" />
</a>

## **License**

This repository is licensed under [Apache 2.0 license](https://github.com/leonardocustodio/polkadart/blob/main/LICENSE)

[pkg:polkadart]: https://pub.dartlang.org/packages/polkadart
[pkg:polkadart:version]: https://img.shields.io/pub/v/polkadart?label=polkadart&link=https%3A%2F%2Fpub.dev%2Fpolkadart
[pkg:polkadart:source]: ./packages/polkadart

[pkg:polkadart_cli]: https://pub.dartlang.org/packages/polkadart_cli
[pkg:polkadart_cli:version]: https://img.shields.io/pub/v/polkadart_cli?label=polkadart_cli
[pkg:polkadart_cli:source]: ./packages/polkadart_cli

[pkg:polkadart_keyring]: https://pub.dartlang.org/packages/polkadart_keyring
[pkg:polkadart_keyring:version]: https://img.shields.io/pub/v/polkadart_keyring?label=polkadart_keyring
[pkg:polkadart_keyring:source]: ./packages/polkadart_keyring

[pkg:polkadart_scale_codec]: https://pub.dartlang.org/packages/polkadart_scale_codec
[pkg:polkadart_scale_codec:version]: https://img.shields.io/pub/v/polkadart_scale_codec?label=polkadart_scale_codec
[pkg:polkadart_scale_codec:source]: ./packages/polkadart_scale_codec

[pkg:secp256k1_ecdsa]: https://pub.dartlang.org/packages/secp256k1_ecdsa
[pkg:secp256k1_ecdsa:version]: https://img.shields.io/pub/v/secp256k1_ecdsa?label=secp256k1_ecdsa
[pkg:secp256k1_ecdsa:source]: ./packages/secp256k1_ecdsa

[pkg:sr25519]: https://pub.dartlang.org/packages/sr25519
[pkg:sr25519:version]: https://img.shields.io/pub/v/sr25519?label=sr25519
[pkg:sr25519:source]: ./packages/sr25519

[pkg:ss58]: https://pub.dartlang.org/packages/ss58
[pkg:ss58:version]: https://img.shields.io/pub/v/ss58?label=ss58
[pkg:ss58:source]: ./packages/ss58

[pkg:substrate_bip39]: https://pub.dartlang.org/packages/substrate_bip39
[pkg:substrate_bip39:version]: https://img.shields.io/pub/v/substrate_bip39?label=substrate_bip39
[pkg:substrate_bip39:source]: ./packages/substrate_bip39

[pkg:substrate_metadata]: https://pub.dartlang.org/packages/substrate_metadata
[pkg:substrate_metadata:version]: https://img.shields.io/pub/v/substrate_metadata?label=substrate_metadata
[pkg:substrate_metadata:source]: ./packages/substrate_metadata

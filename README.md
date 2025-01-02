<p align="center">
<img src="https://raw.githubusercontent.com/leonardocustodio/polkadart/main/resources/polkadart-logo.png" height="100" alt="Polkadart" />
</p>

<p align="center">
<a href="https://github.com/leonardocustodio/polkadart"><img src="https://img.shields.io/github/stars/leonardocustodio/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=Stars" alt="Star on Github"></a>
<a href="https://github.com/leonardocustodio/polkadart/actions/workflows/tests.yml"><img src="https://github.com/leonardocustodio/polkadart/actions/workflows/tests.yml/badge.svg?branch=main" alt="build"></a>
<a href="https://codecov.io/gh/leonardocustodio/polkadart"><img src="https://img.shields.io/codecov/c/github/leonardocustodio/polkadart?label=Codecov&token=HG3K4LW5UN" alt="Codecov"></a>
<a href="#contributors"><img src="https://img.shields.io/github/all-contributors/leonardocustodio/polkadart?color=ee8449&style=flat-square&label=All%20Contributors" alt="All contributors"></a>
<a href="https://www.apache.org/licenses/LICENSE-2.0"><img src="https://img.shields.io/badge/license-Apache%202.0-purple.svg?label=License" alt="License: Apache 2"></a>
<a href="https://t.me/polkadart"><img src="https://img.shields.io/badge/Chat-Telegram-blue.svg?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEyIDI0YzYuNjI3IDAgMTItNS4zNzMgMTItMTJTMTguNjI3IDAgMTIgMCAwIDUuMzczIDAgMTJzNS4zNzMgMTIgMTIgMTJaIiBmaWxsPSJ1cmwoI2EpIi8+PHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik01LjQyNSAxMS44NzFhNzk2LjQxNCA3OTYuNDE0IDAgMCAxIDYuOTk0LTMuMDE4YzMuMzI4LTEuMzg4IDQuMDI3LTEuNjI4IDQuNDc3LTEuNjM4LjEgMCAuMzIuMDIuNDcuMTQuMTIuMS4xNS4yMy4xNy4zMy4wMi4xLjA0LjMxLjAyLjQ3LS4xOCAxLjg5OC0uOTYgNi41MDQtMS4zNiA4LjYyMi0uMTcuOS0uNSAxLjE5OS0uODE5IDEuMjI5LS43LjA2LTEuMjI5LS40Ni0xLjg5OC0uOS0xLjA2LS42ODktMS42NDktMS4xMTktMi42NzgtMS43OTgtMS4xOS0uNzgtLjQyLTEuMjA5LjI2LTEuOTA4LjE4LS4xOCAzLjI0Ny0yLjk3OCAzLjMwNy0zLjIyOC4wMS0uMDMuMDEtLjE1LS4wNi0uMjEtLjA3LS4wNi0uMTctLjA0LS4yNS0uMDItLjExLjAyLTEuNzg4IDEuMTQtNS4wNTYgMy4zNDgtLjQ4LjMzLS45MDkuNDktMS4yOTkuNDgtLjQzLS4wMS0xLjI0OC0uMjQtMS44NjgtLjQ0LS43NS0uMjQtMS4zNDktLjM3LTEuMjk5LS43OS4wMy0uMjIuMzMtLjQ0Ljg5LS42NjlaIiBmaWxsPSIjZmZmIi8+PGRlZnM+PGxpbmVhckdyYWRpZW50IGlkPSJhIiB4MT0iMTEuOTkiIHkxPSIwIiB4Mj0iMTEuOTkiIHkyPSIyMy44MSIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPjxzdG9wIHN0b3AtY29sb3I9IiMyQUFCRUUiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiMyMjlFRDkiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48L3N2Zz4K" alt="Telegram"></a>
</p>

---

<img align="right" width="400" src="https://raw.githubusercontent.com/w3f/Grants-Program/00855ef70bc503433dc9fccc057c2f66a426a82b/static/img/badge_black.svg" />

This library provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node, this API provides developers the ability to query a node and interact with the Polkadot or Substrate chains using Dart.

This library is funded by [Web3 Foundation](https://web3.foundation) via their [Open Grants Program](https://github.com/w3f/Open-Grants-Program)

## Packages

This repo is a monorepo for `polkadart` and related packages.

| Packages <br>____________________ | Description <br>___________                            |
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
| [![version][pkg:ink_abi:version]][pkg:ink_abi]                             | Provides the necessary method to decode and encode ink abi. Making it possible to interact with smart contracts at Polkadot ecosystem.  |

## Documentation

- [Official documentation](https://polkadart.dev)
- [polkadart](https://pub.dev/documentation/polkadart/latest/)
- [polkadart_cli](https://pub.dev/documentation/polkadart_cli/latest/)
- [polkadart_keyring](https://pub.dev/documentation/polkadart_keyring/latest/)
- [polkadart_scale_codec](https://pub.dev/documentation/polkadart_scale_codec/latest/)
- [secp256k1_ecdsa](https://pub.dev/documentation/secp256k1_ecdsa/latest/)
- [sr25519](https://pub.dev/documentation/sr25519/latest/)
- [ss58](https://pub.dev/documentation/ss58/latest/)
- [substrate_bip39](https://pub.dev/documentation/substrate_bip39/latest/)
- [substrate_metadata](https://pub.dev/documentation/substrate_metadata/latest/)
- [ink_abi](https://pub.dev/documentation/ink_abi/latest/)

## Community

 - [Telegram](https://t.me/polkadart) - A developer group where you can share your experience and ask for help

## Contributing

There are many ways for you to contribute to the growing community of Polkadart.
- Propose new features and enhancements
- Report or fix a bug
- Write and improve our documentation
- Translate our documentation
- Add new snippets and examples
- Implement new features by sending pull requets

Contributions of any kind are always welcome! ❤️

## Contributors

A heartfelt thank you to all the contributors for enriching the Polkadart project! [emojis](https://allcontributors.org/docs/en/emoji-key)

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/leonardocustodio"><img src="https://avatars.githubusercontent.com/u/5619696?v=4?s=100" width="100px;" alt="Leonardo Custodio"/><br /><sub><b>Leonardo Custodio</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=leonardocustodio" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=leonardocustodio" title="Tests">⚠️</a> <a href="https://github.com/leonardocustodio/polkadart/pulls?q=is%3Apr+reviewed-by%3Aleonardocustodio" title="Reviewed Pull Requests">👀</a> <a href="#question-leonardocustodio" title="Answering Questions">💬</a> <a href="#maintenance-leonardocustodio" title="Maintenance">🚧</a> <a href="#example-leonardocustodio" title="Examples">💡</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=leonardocustodio" title="Documentation">📖</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3Aleonardocustodio" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://kawal.dev"><img src="https://avatars.githubusercontent.com/u/49296873?v=4?s=100" width="100px;" alt="justkawal"/><br /><sub><b>justkawal</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=justkawal" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=justkawal" title="Tests">⚠️</a> <a href="https://github.com/leonardocustodio/polkadart/pulls?q=is%3Apr+reviewed-by%3Ajustkawal" title="Reviewed Pull Requests">👀</a> <a href="#maintenance-justkawal" title="Maintenance">🚧</a> <a href="#example-justkawal" title="Examples">💡</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3Ajustkawal" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://www.lohannferreira.com.br"><img src="https://avatars.githubusercontent.com/u/4323004?v=4?s=100" width="100px;" alt="Lohann Paterno Coutinho Ferreira"/><br /><sub><b>Lohann Paterno Coutinho Ferreira</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=Lohann" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=Lohann" title="Tests">⚠️</a> <a href="https://github.com/leonardocustodio/polkadart/pulls?q=is%3Apr+reviewed-by%3ALohann" title="Reviewed Pull Requests">👀</a> <a href="#example-Lohann" title="Examples">💡</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3ALohann" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/gabrielokura"><img src="https://avatars.githubusercontent.com/u/26012776?v=4?s=100" width="100px;" alt="Gabriel Okura"/><br /><sub><b>Gabriel Okura</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=gabrielokura" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=gabrielokura" title="Tests">⚠️</a> <a href="#example-gabrielokura" title="Examples">💡</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/clangenb"><img src="https://avatars.githubusercontent.com/u/37865735?v=4?s=100" width="100px;" alt="clangenb"/><br /><sub><b>clangenb</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=clangenb" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=clangenb" title="Tests">⚠️</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3Aclangenb" title="Bug reports">🐛</a> <a href="#question-clangenb" title="Answering Questions">💬</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://pastre.dev"><img src="https://avatars.githubusercontent.com/u/6251198?v=4?s=100" width="100px;" alt="Bruno Pastre"/><br /><sub><b>Bruno Pastre</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/pulls?q=is%3Apr+reviewed-by%3Apastre" title="Reviewed Pull Requests">👀</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/weishirongzhen"><img src="https://avatars.githubusercontent.com/u/54241621?v=4?s=100" width="100px;" alt="weiwei"/><br /><sub><b>weiwei</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=weishirongzhen" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3Aweishirongzhen" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/BurnWW"><img src="https://avatars.githubusercontent.com/u/94514135?v=4?s=100" width="100px;" alt="Burnww"/><br /><sub><b>Burnww</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=BurnWW" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3ABurnWW" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://avive.github.io"><img src="https://avatars.githubusercontent.com/u/96002?v=4?s=100" width="100px;" alt="Aviv Eyal"/><br /><sub><b>Aviv Eyal</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=avive" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/issues?q=author%3Aavive" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/jpnovochadlo"><img src="https://avatars.githubusercontent.com/u/69369894?v=4?s=100" width="100px;" alt="jpnovochadlo"/><br /><sub><b>jpnovochadlo</b></sub></a><br /><a href="#business-jpnovochadlo" title="Business development">💼</a> <a href="#design-jpnovochadlo" title="Design">🎨</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=jpnovochadlo" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/tallesborges"><img src="https://avatars.githubusercontent.com/u/3486359?v=4?s=100" width="100px;" alt="Talles "/><br /><sub><b>Talles </b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=tallesborges" title="Code">💻</a> <a href="https://github.com/leonardocustodio/polkadart/commits?author=tallesborges" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://r3lab.com"><img src="https://avatars.githubusercontent.com/u/49204989?v=4?s=100" width="100px;" alt="Burak"/><br /><sub><b>Burak</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=buraktabn" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

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

[pkg:ink_abi]: https://pub.dartlang.org/packages/ink_abi
[pkg:ink_abi:version]: https://img.shields.io/pub/v/ink_abi?label=ink_abi
[pkg:ink_abi:source]: ./packages/ink_abi

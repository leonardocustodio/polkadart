<p align="center">
<img src="https://raw.githubusercontent.com/leonardocustodio/polkadart/main/resources/polkadart-logo.png" height="120" alt="Polkadart" />
</p>

<h3 align="center">
  The Complete Dart SDK for Polkadot & Substrate
</h3>

<p align="center">
  <em>Build powerful blockchain applications with type-safe Dart & Flutter</em>
</p>

<p align="center">
<a href="https://github.com/leonardocustodio/polkadart"><img src="https://img.shields.io/github/stars/leonardocustodio/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=Stars" alt="Star on Github"></a>
<a href="https://github.com/leonardocustodio/polkadart/actions/workflows/tests.yml"><img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/leonardocustodio/polkadart/tests.yml?style=flat&label=Tests"></a>
<a href="https://codecov.io/gh/leonardocustodio/polkadart"><img src="https://img.shields.io/codecov/c/github/leonardocustodio/polkadart?label=Codecov&token=HG3K4LW5UN" alt="Codecov"></a>
<a href="#contributors"><img src="https://img.shields.io/github/all-contributors/leonardocustodio/polkadart?color=ee8449&label=All%20Contributors" alt="All contributors"></a>
<a href="https://www.apache.org/licenses/LICENSE-2.0"><img src="https://img.shields.io/badge/license-Apache%202.0-purple.svg?label=License" alt="License: Apache 2"></a>
</p>

<p align="center">
  <strong>Get started in minutes</strong> • <strong>Perfect for Flutter apps</strong> • <strong>Production ready</strong>
</p>

---

<img align="right" width="400" src="https://raw.githubusercontent.com/w3f/Grants-Program/00855ef70bc503433dc9fccc057c2f66a426a82b/static/img/badge_black.svg" />

Polkadart is a comprehensive Dart/Flutter SDK that provides everything you need to build decentralized applications on Polkadot, Substrate, and other compatible blockchain networks. With type-safe APIs, automatic code generation, and Flutter-first design, it's the most developer-friendly way to integrate blockchain functionality into your Dart applications.

This library is funded by [Web3 Foundation](https://web3.foundation) via their [Open Grants Program](https://github.com/w3f/Open-Grants-Program)

## ✨ Why Polkadart?

<details>
<summary><strong>🚀 Developer-First Experience</strong></summary>

- **Type-Safe Everything**: Auto-generated types from chain metadata ensure compile-time safety
- **Flutter Ready**: Built from the ground up for mobile and cross-platform development
- **Intuitive APIs**: Clean, idiomatic Dart interfaces that feel natural to use
- **Comprehensive Docs**: Extensive documentation with real-world examples
</details>

<details>
<summary><strong>⚡ Feature Complete</strong></summary>

- **Universal Compatibility**: Works with any Substrate-based blockchain
- **Smart Contracts**: Full support for ink! smart contract interactions
- **Real-time Subscriptions**: WebSocket support for live blockchain data
- **Complete Cryptography**: All signature schemes (sr25519, ed25519, ecdsa) included
- **Advanced Features**: Batch transactions, multi-sig, custom RPCs, and more
</details>

<details>
<summary><strong>🔒 Production Ready</strong></summary>

- **Battle-Tested**: Powers production wallets and dApps with millions of transactions
- **High Performance**: Optimized SCALE codec with minimal overhead
- **Security First**: Comprehensive key management and secure signing
- **Active Maintenance**: Regular updates and active community support
- **Web3 Foundation Backed**: Official grant recipient ensuring long-term sustainability
</details>

## 🚀 Quick Start

### 1. Install Polkadart

```yaml
dependencies:
  polkadart: ^0.7.0
  polkadart_keyring: ^0.7.0
```

### 2. Connect & Query

```dart
import 'package:polkadart/polkadart.dart';

// Connect to Polkadot
final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
final api = await ApiPromise.create(provider);

// Query account balance
final account = '15oF4uVJwmo4TdGW7VfQxNLavjCXviqxT9S1MgbjMNHr6Sp5';
final balance = await api.query.system.account(account);

print('Free balance: ${balance.data.free}');
```

### 3. Send Transactions

```dart
import 'package:polkadart_keyring/polkadart_keyring.dart';

// Create a wallet
final keyring = Keyring();
final alice = await keyring.fromMnemonic('//Alice');

// Send a transfer
final tx = api.tx.balances.transfer(
  dest: '14E5nqKAp3oAJcmzgZhUD2RcptBeUBScxKHgJKU4HPNcKVf3',
  value: BigInt.from(10).pow(12), // 1 DOT
);

final hash = await tx.signAndSend(alice);
print('Transaction hash: $hash');
```

## 📦 Packages

This repository is a monorepo containing the complete Polkadart ecosystem:

### Core Packages

<table width="100%">
<thead>
<tr>
<th align="left">Package</th>
<th align="left">Description</th>
<th align="left">Version</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://pub.dev/packages/polkadart">polkadart</a></td>
<td>Main SDK for Substrate/Polkadot interaction</td>
<td><a href="https://pub.dev/packages/polkadart"><img src="https://img.shields.io/pub/v/polkadart.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/polkadart_keyring">polkadart_keyring</a></td>
<td>Key management and account handling</td>
<td><a href="https://pub.dev/packages/polkadart_keyring"><img src="https://img.shields.io/pub/v/polkadart_keyring.svg" alt="version"></a></td>
</tr>
</tbody>
</table>

### Developer Tools

<table width="100%">
<thead>
<tr>
<th align="left">Package</th>
<th align="left">Description</th>
<th align="left">Version</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://pub.dev/packages/polkadart_cli">polkadart_cli</a></td>
<td>Generate typed APIs from chain metadata</td>
<td><a href="https://pub.dev/packages/polkadart_cli"><img src="https://img.shields.io/pub/v/polkadart_cli.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/ink_cli">ink_cli</a></td>
<td>Generate typed interfaces for smart contracts</td>
<td><a href="https://pub.dev/packages/ink_cli"><img src="https://img.shields.io/pub/v/ink_cli.svg" alt="version"></a></td>
</tr>
</tbody>
</table>

### Low-Level Primitives

<table width="100%">
<thead>
<tr>
<th align="left">Package</th>
<th align="left">Description</th>
<th align="left">Version</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://pub.dev/packages/polkadart_scale_codec">polkadart_scale_codec</a></td>
<td>SCALE codec implementation</td>
<td><a href="https://pub.dev/packages/polkadart_scale_codec"><img src="https://img.shields.io/pub/v/polkadart_scale_codec.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/substrate_metadata">substrate_metadata</a></td>
<td>Runtime metadata parsing</td>
<td><a href="https://pub.dev/packages/substrate_metadata"><img src="https://img.shields.io/pub/v/substrate_metadata.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/ink_abi">ink_abi</a></td>
<td>ink! ABI encoding/decoding</td>
<td><a href="https://pub.dev/packages/ink_abi"><img src="https://img.shields.io/pub/v/ink_abi.svg" alt="version"></a></td>
</tr>
</tbody>
</table>

### Cryptography

<table width="100%">
<thead>
<tr>
<th align="left">Package</th>
<th align="left">Description</th>
<th align="left">Version</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://pub.dev/packages/sr25519">sr25519</a></td>
<td>Schnorrkel signature scheme</td>
<td><a href="https://pub.dev/packages/sr25519"><img src="https://img.shields.io/pub/v/sr25519.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/secp256k1_ecdsa">secp256k1_ecdsa</a></td>
<td>ECDSA operations</td>
<td><a href="https://pub.dev/packages/secp256k1_ecdsa"><img src="https://img.shields.io/pub/v/secp256k1_ecdsa.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/ss58">ss58</a></td>
<td>SS58 address encoding</td>
<td><a href="https://pub.dev/packages/ss58"><img src="https://img.shields.io/pub/v/ss58.svg" alt="version"></a></td>
</tr>
<tr>
<td><a href="https://pub.dev/packages/substrate_bip39">substrate_bip39</a></td>
<td>BIP39 mnemonic generation</td>
<td><a href="https://pub.dev/packages/substrate_bip39"><img src="https://img.shields.io/pub/v/substrate_bip39.svg" alt="version"></a></td>
</tr>
</tbody>
</table>

## 📚 Documentation

<details>
<summary><strong>Getting Started</strong></summary>

- [Installation Guide](https://pub.dev/documentation/polkadart/latest/)
- [Quick Start Tutorial](https://polkadart.dev)
- [API Reference](https://pub.dev/documentation/polkadart/latest/)
- [Examples](https://github.com/leonardocustodio/polkadart/tree/main/apps/examples)
</details>

<details>
<summary><strong>Advanced Topics</strong></summary>

- [Type Generation](https://pub.dev/documentation/polkadart_cli/latest/)
- [Smart Contracts](https://pub.dev/documentation/ink_cli/latest/)
- [Custom RPCs](https://polkadart.dev)
- [Multi-signature](https://polkadart.dev)
</details>

<details>
<summary><strong>Package Documentation</strong></summary>

- [polkadart](https://pub.dev/documentation/polkadart/latest/)
- [polkadart_cli](https://pub.dev/documentation/polkadart_cli/latest/)
- [polkadart_keyring](https://pub.dev/documentation/polkadart_keyring/latest/)
- [polkadart_scale_codec](https://pub.dev/documentation/polkadart_scale_codec/latest/)
- [substrate_metadata](https://pub.dev/documentation/substrate_metadata/latest/)
- [ink_abi](https://pub.dev/documentation/ink_abi/latest/)
- [ink_cli](https://pub.dev/documentation/ink_cli/latest/)
- [sr25519](https://pub.dev/documentation/sr25519/latest/)
- [secp256k1_ecdsa](https://pub.dev/documentation/secp256k1_ecdsa/latest/)
- [ss58](https://pub.dev/documentation/ss58/latest/)
- [substrate_bip39](https://pub.dev/documentation/substrate_bip39/latest/)
</details>

## 🤝 Community & Support

<table>
<tr>
<td width="50%">

### Get Help

- 💬 [Matrix Chat](https://matrix.to/#/%23polkadart:matrix.org) - Developer discussions
- 📖 [API Documentation](https://polkadart.dev) - Complete reference
- 🐛 [Issue Tracker](https://github.com/leonardocustodio/polkadart/issues) - Report bugs
- 💡 [Discussions](https://github.com/leonardocustodio/polkadart/discussions) - Feature requests

</td>
<td width="50%">

### Showcase

- 📱 [Encointer Wallet](https://github.com/encointer/encointer-wallet-flutter) - Production wallet
- 🏛️ [Polkadot Forum](https://forum.polkadot.network/t/introducing-polkadart/10697) - Official announcement
- 🎮 [Example Apps](https://github.com/leonardocustodio/polkadart/tree/main/apps/examples) - Sample code
- 🚀 [Your App Here!](https://github.com/leonardocustodio/polkadart/issues/new) - Share your project

</td>
</tr>
</table>

## 🎯 Contributing

We welcome contributions from developers of all skill levels! Here's how you can help:

<table>
<tr>
<td width="33%">

### 🐛 Report & Fix

- Report bugs
- Fix issues
- Improve tests
- Update docs

</td>
<td width="33%">

### ✨ Enhance

- Add features
- Write examples
- Create tutorials
- Translate docs

</td>
<td width="33%">

### 🚀 Share

- Star the repo
- Share projects
- Write articles
- Join discussions

</td>
</tr>
</table>

Every contribution matters! Check our [Contributing Guide](CONTRIBUTING.md) for details.

## 👥 Contributors

A heartfelt thank you to all the amazing contributors who have helped build Polkadart! [emoji key](https://github.com/all-contributors/all-contributors/blob/master/docs/emoji-key.md)

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
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/vjrj"><img src="https://avatars.githubusercontent.com/u/180085?v=4?s=100" width="100px;" alt="vjrj"/><br /><sub><b>vjrj</b></sub></a><br /><a href="https://github.com/leonardocustodio/polkadart/commits?author=vjrj" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome! ❤️

## 📜 License

This project is licensed under the [Apache 2.0 License](LICENSE)

## 🚀 What's Next?

Ready to build your next blockchain application? Here's where to go:

- 📖 [Read the Documentation](https://polkadart.dev) - Complete guides and tutorials
- 💻 [Explore Examples](https://github.com/leonardocustodio/polkadart/tree/main/apps/examples) - Working code samples
- 💬 [Join the Community](https://matrix.to/#/%23polkadart:matrix.org) - Get help and share ideas
- ⭐ [Star the Project](https://github.com/leonardocustodio/polkadart) - Show your support!

---

<p align="center">
  <strong>Build the future of Web3 with Dart & Flutter 🚀</strong><br>
  <em>Making Polkadot development accessible to millions of developers worldwide</em>
</p>


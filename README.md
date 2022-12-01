[![Star on Github](https://img.shields.io/github/stars/rankanizer/polkadart.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/rankanizer/polkadart)
[![Test Coverage](https://api.codeclimate.com/v1/badges/156365ed1c65ff0d7b8c/test_coverage)](https://codeclimate.com/github/rankanizer/polkadart/test_coverage)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-purple.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Frankanizer%2Fpolkadart.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Frankanizer%2Fpolkadart?ref=badge_shield) <!-- markdown-link-check-disable-line -->

# polkadart

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

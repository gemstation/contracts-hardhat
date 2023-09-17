# @gemstation/contracts-hardhat

Example smart contracts repo for [Gemforge](https://gemforge.xyz) using [Hardhat](https://hardhat.org/).

This contains the optimal folder structure for use with Gemforge:

* Build and deploy commands already setup
* Pre-configured config file
* Post-deploy hook for Etherscan verification

There are two facets provided:

* `ExampleFacet` - a simple example of a facet with a single function. Try adding and removing functions to/from this facet to see how the Gemforge deployment changes.
* `ERC20Facet` - a complex example demonstrating how to deploy multiple separate ERC20s token contracts all internally backed by the same upgradeable diamond proxy ([read more](https://hiddentao.com/archives/2023/08/08/building-multiple-nft-and-erc-20-tokens-backed-by-a-single-upgradeable-smart-contract)).

_Note: A Foundry equivalent of this repo is available at https://github.com/gemstation/contracts-foundry_

## Requirements

* [Node.js 20+](https://nodejs.org)
* [PNPM](https://pnpm.io/) _(NOTE: `yarn` and `npm` can also be used)_

## Installation

In an empty folder:

```
npx gemforge scaffold --hardhat
```

Change into the folder and run in order:

```
$ git submodule update --init --recursive
$ pnpm i
```

Create `.env` and set the following within:

```
LOCAL_RPC_URL=http://localhost:8545
SEPOLIA_RPC_URL=<your infura/alchemy endpoint for spolia>
ETHERSCAN_API_KEY=<your etherscan api key>
MNEMONIC=<your deployment wallet mnemonic>
```

## Usage

Run a local dev node in a separate terminal:

```
pnpm devnet
```

To build the code:

```
$ pnpm build
```

To deploy to the local node:

```
$ pnpm dep local
```

To deploy to Sepolia testnet:

```
$ pnpm dep testnet
```

For verbose output simply add `-v`:

```
$ pnpm build -v
$ pnpm dep -v
```

## License

MIT - see [LICSENSE.md](LICENSE.md)

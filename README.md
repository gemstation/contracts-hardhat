# @gemstation/contracts-hardhat

Example smart contracts repo for [Gemforge](https://gemforge.xyz) using [Hardhat](https://hardhat.org/).

This contains the optimal folder structure for use with Gemforge:

* Build and deploy commands already setup
* Pre-configured config file

There are two facets provided:

* `ExampleFacet` - a simple example of a facet with a single function. Try adding and removing functions to/from this facet to see how the Gemforge deployment changes.
* `ERC20Facet` - a complex example demonstrating how to deploy multiple separate ERC20s token contracts all internally backed by the same upgradeable diamond proxy ([read more](https://hiddentao.com/archives/2023/08/08/building-multiple-nft-and-erc-20-tokens-backed-by-a-single-upgradeable-smart-contract)).

_Note: A Foundry equivalent of this repo is available at https://github.com/gemstation/contracts-foundry_

## Requirements

* [Node.js 20+](https://nodejs.org)
* [PNPM](https://pnpm.io/) _(NOTE: `yarn` and `npm` can also be used)_

## Installation

In an empty folder:

```shell
npx gemforge scaffold --hardhat
```

Change into the folder and run in order:

```shell
$ git submodule update --init --recursive
$ pnpm i
```

## Usage

Run a local dev node in a separate terminal:

```shell
pnpm devnet
```

To build the code:

```shell
$ pnpm build
```

### Deploy to local devnet

To deploy to the `local` target:

```shell
$ pnpm dep local
```

### Deploy to testnet (Base Sepolia)

You first need to configure the deployment wallet private key in your environment. Ensure that this wallet has a non-zero balance of Base Sepolia ETH (you can use [Alchemy's faucet](https://www.alchemy.com/faucets/base-sepolia) to get some):

```shell
$ export PRIVATE_KEY=<your Base Sepolia deployment wallet private key>
```

Now register on https://basescan.org and generate an API key to set in the environment. This will be used for contract source verification on basescan:

```shell
$ export BASESCAN_API_KEY=<api key obtained from basescan.org>
```

Now run:

```shell
$ pnpm dep base_sepolia
```

If you visit https://sepolia.basescan.org you should see the deployed contracts along with verified source code.

### Miscellanous

For verbose output simply add `-v` to the commands:

```shell
$ pnpm build -v
$ pnpm dep -v
```

## License

MIT - see [LICSENSE.md](LICENSE.md)

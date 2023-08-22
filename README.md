# @gemstation/contracts-hardhat

Example smart contracts repo for [Gemforge](https://gemforge.xyz) using [Hardhat](https://hardhat.org/).

This contains the optimal folder structure for use with Gemforge:

* Build and deploy commands already setup
* Pre-configured config file
* Post-deploy hook for Etherscan verification
* ERC20 token facade with tests

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
$ pnpm dep
```

To deploy to Sepolia testnet:

```
$ pnpm dep sepolia
```

For verbose output simply add `-v`:

```
$ pnpm build -v
$ pnpm dep -v
```

## License

MIT - see [LICSENSE.md](LICENSE.md)

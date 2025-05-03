# FundMe Smart Contract

A crowdfunding smart contract built with Solidity and Foundry.

## Features

- Fund the contract with ETH
- Minimum funding amount in USD (using Chainlink price feeds)
- Only owner can withdraw funds

## Contract **Deployments**

- Sepolia: [0xa8A7896FA44120618B2638616361C24Faf16A30d](https://sepolia.etherscan.io/address/0xa8a7896fa44120618b2638616361c24faf16a30d)

## Getting Started

### Prerequisites

- Foundry

### Quick Start

```shell
git clone <repo-url>
forge install
forge build
```

### Deploy

```shell
# Local
make anvil
make deploy

# Sepolia
# Add SEPOLIA_RPC_URL, PRIVATE_KEY, ETHERSCAN_API_KEY to .env
make deploy-sepolia
```

### Interact

```shell
make fund    # Fund contract
make withdraw # Withdraw funds (owner only)
```

### Contract ABI

```shell
forge inspect src/FundMe.sol:FundMe abi --json > abi/FundMe.json
```

## License

MIT

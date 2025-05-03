# FundMe Smart Contract

A crowdfunding smart contract built with Solidity and Foundry that allows users to fund a project and the owner to withdraw the funds.

## Features

- Users can fund the contract with ETH
- Minimum funding amount in USD (using Chainlink price feeds)
- Only the owner can withdraw funds
- Automatic USD/ETH conversion using Chainlink Oracle

## Contract Deployments

- Sepolia Testnet: [0xa8A7896FA44120618B2638616361C24Faf16A30d](https://sepolia.etherscan.io/address/0xa8a7896fa44120618b2638616361c24faf16a30d)

## Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/)

### Installation

1. Clone the repository
```shell
git clone https://github.com/your-username/fund-me-foundry.git
cd fund-me-foundry
```

2. Install dependencies
```shell
forge install
```

3. Build the project
```shell
forge build
```

### Testing

```shell
forge test
```

### Deployment

#### Local Deployment (Anvil)
```shell
# Start local node
make anvil

# In a separate terminal
make deploy
```

#### Testnet Deployment (Sepolia)
1. Set up environment variables in `.env`:
```
SEPOLIA_RPC_URL=your_rpc_url
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
```

2. Deploy to Sepolia:
```shell
make deploy-sepolia
```

### Interacting with the Contract

#### Fund the Contract
```shell
make fund
```

#### Withdraw Funds (Owner only)
```shell
make withdraw
```

## Contract ABI

Generate the contract ABI:
```shell
mkdir -p abi
forge inspect src/FundMe.sol:FundMe abi --json > abi/FundMe.json
```

## License

MIT

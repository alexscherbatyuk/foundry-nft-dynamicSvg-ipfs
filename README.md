# Foundry NFT Collection

A comprehensive NFT project demonstrating both classic IPFS-based NFTs and dynamic on-chain SVG NFTs using Foundry framework.

## 🎯 Project Overview

This project showcases two different approaches to NFT implementation:

- **BasicNft**: A classic ERC721 NFT that stores metadata on IPFS
- **MoodNft**: A dynamic on-chain SVG NFT that can change its appearance based on mood

## 🚀 Features

### BasicNft (Classic IPFS NFT)
- Standard ERC721 implementation using OpenZeppelin
- Custom token URI storage during minting
- Support for IPFS, Filecoin, Arweave, or any metadata storage
- Simple minting with custom metadata URI

### MoodNft (Dynamic On-Chain SVG NFT)
- Fully on-chain SVG-based NFT
- Dynamic mood switching (Happy ↔ Sad)
- Base64 encoded metadata
- Owner-only mood flipping functionality
- Australian Cattle Dog themed collection

## 📋 Prerequisites

- [Foundry](https://getfoundry.sh/) installed
- Git
- Node.js (for additional tooling if needed)

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd foundry-nft
   ```

2. **Install dependencies**
   ```bash
   make install
   ```

## 🏗️ Building

```bash
make build
```

## 🧪 Testing

```bash
make test
```

## 📝 Code Formatting

```bash
make fmt
```

## 📊 Gas Analysis

```bash
forge snapshot
```

## 🚀 Deployment

### Local Development (Anvil)

#### Deploy BasicNft
```bash
make deploy-anvil
```

#### Deploy MoodNft
```bash
make deploy-mood-anvil
```

### Sepolia Testnet

#### Deploy BasicNft
```bash
make deploy-sepolia
```

#### Deploy MoodNft
```bash
make deploy-mood-sepolia
```

**Note**: For Sepolia deployment, ensure you have the following environment variables set:
- `SEPOLIA_RPC_URL`
- `ETHERSCAN_API_KEY`
- `PRIVATE_KEY` (for the devKey account)

## 🎨 NFT Interaction

### Minting NFTs

#### Local (Anvil)
```bash
# Mint BasicNft
make mint-nft-anvil

# Mint MoodNft
make mint-mood-anvil
```

#### Sepolia Testnet
```bash
# Mint BasicNft
make mint-nft-sepolia

# Mint MoodNft
make mint-mood-sepolia
```

### MoodNft Features

The MoodNft contract includes these key functions:

- `mintNft()`: Mint a new NFT (starts with happy mood)
- `flipMood(uint256 _tokenId)`: Change the mood of your NFT
- `tokenURI(uint256 _tokenId)`: Get the metadata URI
- `getTokenCounter()`: Get total number of minted tokens

## 📁 Project Structure

```
foundry-nft/
├── src/
│   ├── BasicNft.sol      # Classic IPFS-based NFT
│   └── MoodNft.sol       # Dynamic on-chain SVG NFT
├── script/
│   ├── DeployBasicNft.s.sol
│   ├── DeployMoodNft.s.sol
│   └── Interactions.s.sol
├── test/                 # Test files
├── img/                  # NFT images and SVGs
├── Makefile             # Build and deployment commands
└── foundry.toml         # Foundry configuration
```

## 🎭 NFT Examples

<div style="display: flex; gap: 20px; align-items: center; margin: 20px 0;">
    <div style="text-align: center;">
        <img src="img/0-blue.png" width="100" height="100" alt="Classic PNG IPFS NFT"/>
        <p><strong>BasicNft</strong><br/>Classic IPFS-based</p>
    </div>
    <div style="text-align: center;">
        <img src="img/happy-blue.svg" width="100" height="100" alt="Happy Mood SVG"/>
        <p><strong>MoodNft</strong><br/>Happy Mood</p>
    </div>
    <div style="text-align: center;">
        <img src="img/sad-blue.svg" width="100" height="100" alt="Sad Mood SVG"/>
        <p><strong>MoodNft</strong><br/>Sad Mood</p>
    </div>
</div>

## 🔧 Development

### Starting Local Blockchain
```bash
anvil
```

### Running Tests
```bash
forge test
```

### Gas Optimization
```bash
forge snapshot
```

## 📚 Contract Details

### BasicNft.sol
- **Name**: "Dogie"
- **Symbol**: "DOG"
- **Standard**: ERC721
- **Metadata**: External storage (IPFS, etc.)

### MoodNft.sol
- **Name**: "MoodNft"
- **Symbol**: "MNT"
- **Standard**: ERC721
- **Metadata**: On-chain Base64 encoded
- **Collection**: 1000 Australian Cattle Dogs
- **Moods**: Happy, Sad

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- [OpenZeppelin](https://openzeppelin.com/) for secure smart contract libraries
- [Foundry](https://getfoundry.sh/) for the development framework
- [Cyfrin](https://www.cyfrin.io/) for educational content

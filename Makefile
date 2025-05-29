-include .env

.PHONY: all install build clean fmt remove test deploy snapshot

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

test:; forge test

fmt:; forge fmt

anvil:; anvil

snapshot:; snapshot

deploy-anvil:
	@forge script script/DeployBasicNft.s.sol --rpc-url 127.0.0.1:8545 --broadcast --account defaultKey --password-file .password -vvvv

deploy-sepolia:
	@forge script script/DeployBasicNft.s.sol --rpc-url $(SEPOLIA_RPC_URL) --account devKey --password-file .password --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-mood-anvil:
	@forge script script/DeployMoodNft.s.sol --rpc-url 127.0.0.1:8545 --broadcast --account defaultKey --password-file .password -vvvv

deploy-mood-sepolia:
	@forge script script/DeployMoodNft.s.sol --rpc-url $(SEPOLIA_RPC_URL) --account devKey --password-file .password --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

mint-nft-anvil:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url 127.0.0.1:8545 --broadcast --account defaultKey --password-file .password -vvvv

mint-nft-sepolia:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(SEPOLIA_RPC_URL) --broadcast --account devKey --password-file .password -vvvv

mint-mood-anvil:
	@forge script script/Interactions.s.sol:MintMoodNft --rpc-url 127.0.0.1:8545 --broadcast --account defaultKey --password-file .password -vvvv

mint-mood-sepolia:
	@forge script script/Interactions.s.sol:MintMoodNft --rpc-url $(SEPOLIA_RPC_URL) --broadcast --account devKey --password-file .password -vvvv

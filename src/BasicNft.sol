// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title Basic NFT contract
 * @author Alexander Scherbatyuk
 * @notice This contract is a standard ERC721 token that allows user to populate tokenURI
 * during the mint providing users with an opportunity to store token metadata in any
 * suitable form like IPFS, Filecoin, Arweave, etc.
 * @dev This contract inherits from OpenZeppelin's ERC721 implementation and adds
 * custom token URI storage functionality
 */
contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    /* Functions */
    /**
     * @notice Constructor initializes the NFT contract with name "Dogie" and symbol "DOG"
     * @dev Sets the initial token counter to 0
     */
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    /* Public */
    /**
     * @notice Mints a new NFT to the caller with the specified token URI
     * @param _tokenURI The URI containing the metadata for the NFT (can be IPFS, HTTP, etc.)
     * @dev This function increments the token counter and assigns the token to msg.sender
     * @dev The token URI is stored in the mapping for later retrieval
     */
    function mintNft(string memory _tokenURI) public {
        s_tokenIdToUri[s_tokenCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /* External & public view & pure functions */
    /**
     * @notice Returns the token URI for a given token ID
     * @param _tokenId The ID of the token to get the URI for
     * @return The URI string containing the token's metadata
     * @dev This function overrides the ERC721 tokenURI function
     */
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }

    /**
     * @notice Returns the current token counter value
     * @return The total number of tokens that have been minted
     * @dev This can be used to determine the next token ID that will be minted
     */
    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}

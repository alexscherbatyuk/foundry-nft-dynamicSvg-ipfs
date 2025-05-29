// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title Basic NFT contract
 * @author Alexander Scherbatyuk
 * @notice This contract is a standard ERC721 token that allows user to populate tokenURI
 * during the mint providing users with an opportunity to store token metadata in any
 * suitable form like IPFS, Filecoin, Arweave, etc.
 */
contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    /* Functions */
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    /* Public */
    function mintNft(string memory _tokenURI) public {
        s_tokenIdToUri[s_tokenCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /* External & public view & pure functions */
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}

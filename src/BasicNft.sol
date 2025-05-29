// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokecCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Dogie", "DOG") {
        s_tokecCounter = 0;
    }

    function mintNft(string memory _tokenURI) public {
        s_tokenIdToUri[s_tokecCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokecCounter);
        s_tokecCounter++;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}

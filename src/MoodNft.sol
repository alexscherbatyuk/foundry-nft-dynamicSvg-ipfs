// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    //errors
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokecCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory _sadSvgImageUri, string memory _happySvgImageUri) ERC721("MoodNft", "MNT") {
        s_tokecCounter = 0;
        s_sadSvgImageUri = _sadSvgImageUri;
        s_happySvgImageUri = _happySvgImageUri;
    }

    function mintNft() public {
        s_tokenIdToMood[s_tokecCounter] = Mood.HAPPY;
        _safeMint(msg.sender, s_tokecCounter);
        s_tokecCounter++;
    }

    function flipMood(uint256 _tokenId) public {
        //only whant the NFT owner to be able to change the mood
        if (!_isAuthorized(_ownerOf(_tokenId), msg.sender, _tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[_tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[_tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        //abi.encodePacked, or string.constant
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '","description":"A collection of 1000 Australian Cattle Dogs or simply Blues.", "attributes": [{"trait_type": "moodiness","value": "100"}],"image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function getHappySVG() public view returns (string memory) {
        return s_happySvgImageUri;
    }

    function getSadSVG() public view returns (string memory) {
        return s_sadSvgImageUri;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokecCounter;
    }
}

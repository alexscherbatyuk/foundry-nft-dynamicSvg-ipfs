// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title Mood NFT is a dynamic svg based on-chain NFT
 * @author Alexander Scherbatyuk
 * @notice This contract is a standard ERC721 token that:
 * - utilizes SVG,
 * - stores data on-chain, making this type of NFT truly decentrlized,
 * - gives features to change it state (SVG) by request
 */
contract MoodNft is ERC721 {
    /* Errors */
    error MoodNft__CantFlipMoodIfNotOwner();

    /* Type declarations */
    enum Mood {
        HAPPY,
        SAD
    }

    /* State variables */
    uint256 private s_tokecCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    /* Functions */
    constructor(string memory _sadSvgImageUri, string memory _happySvgImageUri) ERC721("MoodNft", "MNT") {
        s_tokecCounter = 0;
        s_sadSvgImageUri = _sadSvgImageUri;
        s_happySvgImageUri = _happySvgImageUri;
    }

    /* Public */
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

    /* Internal & private view & pure functions */

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /* External & public view & pure functions */

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

    function getHappySVG() external view returns (string memory) {
        return s_happySvgImageUri;
    }

    function getSadSVG() external view returns (string memory) {
        return s_sadSvgImageUri;
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokecCounter;
    }
}

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

// CEI:
// Check
// Effect
// Interaction

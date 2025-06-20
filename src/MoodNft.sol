// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title Mood NFT
 * @author Alexander Scherbatyuk
 * @notice A dynamic SVG-based on-chain NFT that allows owners to change the mood of their NFT
 * @dev This contract extends ERC721 and stores SVG data on-chain, making it truly decentralized.
 * The NFT can switch between happy and sad moods, with the SVG changing accordingly.
 * @custom:security This contract uses OpenZeppelin's ERC721 implementation for security.
 */
contract MoodNft is ERC721 {
    /* Errors */
    /// @notice Error thrown when a non-owner tries to flip the mood of an NFT
    error MoodNft__CantFlipMoodIfNotOwner();

    /* Type declarations */
    /// @notice Enum representing the possible moods of the NFT
    enum Mood {
        HAPPY,
        SAD
    }

    /* State variables */
    /// @notice Counter for tracking the next token ID to be minted
    uint256 private s_tokenCounter;
    /// @notice SVG image URI for the sad mood
    string private s_sadSvgImageUri;
    /// @notice SVG image URI for the happy mood
    string private s_happySvgImageUri;
    /// @notice Mapping from token ID to its current mood
    mapping(uint256 => Mood) private s_tokenIdToMood;

    /* Functions */
    /**
     * @notice Constructor to initialize the MoodNft contract
     * @param _sadSvgImageUri The SVG image URI for the sad mood
     * @param _happySvgImageUri The SVG image URI for the happy mood
     * @dev Initializes the contract with the provided SVG URIs and sets the token counter to 0
     */
    constructor(string memory _sadSvgImageUri, string memory _happySvgImageUri) ERC721("MoodNft", "MNT") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = _sadSvgImageUri;
        s_happySvgImageUri = _happySvgImageUri;
    }

    /* Public */
    /**
     * @notice Mints a new NFT with happy mood to the caller
     * @dev Increments the token counter and assigns the new token to msg.sender
     * The newly minted NFT starts with a happy mood
     */
    function mintNft() public {
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /**
     * @notice Flips the mood of an NFT from happy to sad or vice versa
     * @param _tokenId The ID of the token whose mood should be flipped
     * @dev Only the owner of the NFT can flip its mood
     * @custom:revert MoodNft__CantFlipMoodIfNotOwner if the caller is not the owner of the token
     */
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

    /**
     * @notice Returns the base URI for token metadata
     * @return The base URI string for JSON metadata
     * @dev Overrides the ERC721 _baseURI function to return a data URI prefix
     */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /* External & public view & pure functions */

    /**
     * @notice Returns the token URI for a given token ID
     * @param _tokenId The ID of the token
     * @return The complete token URI containing metadata and image
     * @dev Returns a base64 encoded JSON string with token metadata including the appropriate SVG based on mood
     */
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

    /**
     * @notice Returns the SVG image URI for the happy mood
     * @return The SVG image URI for happy mood
     */
    function getHappySVG() external view returns (string memory) {
        return s_happySvgImageUri;
    }

    /**
     * @notice Returns the SVG image URI for the sad mood
     * @return The SVG image URI for sad mood
     */
    function getSadSVG() external view returns (string memory) {
        return s_sadSvgImageUri;
    }

    /**
     * @notice Returns the current token counter
     * @return The number of tokens that have been minted
     * @dev This can be used to determine the next token ID that will be minted
     */
    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
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

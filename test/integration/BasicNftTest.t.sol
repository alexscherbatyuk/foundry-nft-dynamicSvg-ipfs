// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";

contract BasicNftTes is Test {
    DeployBasicNft public deployBasicNft;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    string public constant TOKEN_URI =
        "ipfs://bafkreiehwfkha5ujzm7cwqjrw6rstuhffhm7usl6kl4klwwc5lcxmrhq3y?filename=0-blue.json";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    /*//////////////////////////////////////////////////////////////
                         BASIC NFT INTEGRATION
    //////////////////////////////////////////////////////////////*/

    function testNameIsCorrect() public view {
        string memory expextedName = "Dogie";
        string memory actualName = basicNft.name();

        // Method 1: Manual string comparison
        // This method manually compares the keccak256 hashes of the packed strings
        // It's more verbose but shows explicitly how string comparison works under the hood
        assert(keccak256(abi.encodePacked(expextedName)) == keccak256(abi.encodePacked(actualName)));

        // Method 2: Using Forge's assertEq
        // This is a helper function provided by Forge's Test contract that does the same comparison
        // It's cleaner and provides better error messages when the assertion fails
        assertEq(basicNft.name(), "Dogie");
    }

    function testCanMintAndHaveABalance() public {
        // Arrange
        vm.prank(USER);
        // Act
        basicNft.mintNft(TOKEN_URI);
        // Assert
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(TOKEN_URI)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}

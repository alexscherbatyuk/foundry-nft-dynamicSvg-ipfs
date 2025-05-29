// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {MintBasicNft} from "script/Interactions.s.sol";

contract InteractionsBasicNftTest is Test {
    MintBasicNft mintBasicNft;
    BasicNft basicNft;

    function setUp() public {
        basicNft = new BasicNft();
        mintBasicNft = new MintBasicNft();
    }

    function testMintNftOnContract() public {
        mintBasicNft.mintNftOnContract(address(basicNft));
    }
}

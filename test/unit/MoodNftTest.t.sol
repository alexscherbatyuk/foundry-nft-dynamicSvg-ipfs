// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;

    string public HAPPY_SVG_URI = vm.readFile("./img/sad-blue.svg");
    string public SAD_SVG_URI = vm.readFile("./img/happy-blue.svg");

    string public constant SAD_TOKEN_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsImRlc2NyaXB0aW9uIjoiQSBjb2xsZWN0aW9uIG9mIDEwMDAgQXVzdHJhbGlhbiBDYXR0bGUgRG9ncyBvciBzaW1wbHkgQmx1ZXMuIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsInZhbHVlIjogIjEwMCJ9XSwiaW1hZ2UiOiI8c3ZnIHZpZXdCb3g9IjUwIDEwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgPgogIDwhLS0gSGVhZCAtLT4KICA8cGF0aAogICAgZD0iTTcwIDcwIFE4MCAzMCAxMTAgNDAgUTE0MCAzMCAxNDAgNzAgUTEzMCA5MCAxMTAgOTUgUTkwIDk1IDcwIDcwIFoiCiAgICBmaWxsPSIjOTBhNGFlIgogICAgc3Ryb2tlPSIjMzQ0OTVlIgogICAgc3Ryb2tlLXdpZHRoPSIzIgogIC8+CiAgCiAgPCEtLSBFYXJzIC0tPgogIDxwb2x5Z29uIHBvaW50cz0iNzUsNTAgODUsMTUgOTUsNTAiIGZpbGw9IiMzNDQ5NWUiIC8+CiAgPHBvbHlnb24gcG9pbnRzPSIxMjUsNTAgMTM1LDE1IDE0NSw1MCIgZmlsbD0iIzM0NDk1ZSIgLz4KICAKICA8IS0tIFNhZCBFeWVzIChlbGxpcHRpY2FsLCBzbGlnaHRseSB0aWx0ZWQgZG93bndhcmQpIC0tPgogIDxlbGxpcHNlIGN4PSI5NSIgY3k9IjcyIiByeD0iNSIgcnk9IjMuNSIgZmlsbD0iYmxhY2siIHRyYW5zZm9ybT0icm90YXRlKC0xNSA5NSA3MikiIC8+CiAgPGVsbGlwc2UgY3g9IjEyNSIgY3k9IjcyIiByeD0iNSIgcnk9IjMuNSIgZmlsbD0iYmxhY2siIHRyYW5zZm9ybT0icm90YXRlKDE1IDEyNSA3MikiIC8+CiAgCiAgPCEtLSBOb3NlIC0tPgogIDxjaXJjbGUgY3g9IjExMCIgY3k9IjkwIiByPSI0IiBmaWxsPSJibGFjayIgLz4KICAKICA8IS0tIFNhZCBNb3V0aCAoZG93bndhcmQgY3VydmUpIC0tPgogIDxwYXRoIGQ9Ik0xMDAgMTA1IFExMTAgOTUgMTIwIDEwNSIgc3Ryb2tlPSIjMzQ0OTVlIiBzdHJva2Utd2lkdGg9IjMiIGZpbGw9Im5vbmUiIC8+Cjwvc3ZnPgoifQ==";

    address public USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    /*//////////////////////////////////////////////////////////////
                      DEPLOY MOODNFT UNIT TESTING
    //////////////////////////////////////////////////////////////*/

    function testViewTokenURI() public {
        // Arrange
        vm.prank(USER);

        // Act
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));

        // Assert
        assertEq(moodNft.tokenURI(0), SAD_TOKEN_URI);
    }

    function testGetHappySVG() public view {
        // Arrange / Act
        string memory happySvg = moodNft.getHappySVG();

        // Assert
        assertEq(happySvg, HAPPY_SVG_URI, "Happy SVG URI should match");
    }

    function testGetSadSVG() public view {
        // Arrange / Act
        string memory sadSvg = moodNft.getSadSVG();

        // Assert
        assertEq(sadSvg, SAD_SVG_URI, "Sad SVG URI should match");
    }

    function testGetTokenCounter() public {
        // Arrange
        uint256 initialCounter = moodNft.getTokenCounter();
        vm.prank(USER);

        // Act
        moodNft.mintNft();
        uint256 counterAfterMint = moodNft.getTokenCounter();

        // Assert
        assertEq(initialCounter, 0, "Initial token counter should be 0");
        assertEq(counterAfterMint, 1, "Token counter should be 1 after minting");
    }
}

// AAA:
// Arrange
// Act
// Assert

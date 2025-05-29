// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;

    string public HAPPY_SVG_URI = vm.readFile("./img/sad-blue.svg");
    string public SAD_SVG_URI = vm.readFile("./img/happy-blue.svg");

    //string public constant HAPPY_SVG_URI ="data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSI1MCAxMCAxMDAgMTAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciID4KICA8IS0tIEhlYWQgLS0+CiAgPHBhdGgKICAgIGQ9Ik03MCA3MCBRODAgMzAgMTEwIDQwIFExNDAgMzAgMTQwIDcwIFExMzAgOTAgMTEwIDk1IFE5MCA5NSA3MCA3MCBaIgogICAgZmlsbD0iIzkwYTRhZSIKICAgIHN0cm9rZT0iIzM0NDk1ZSIKICAgIHN0cm9rZS13aWR0aD0iMyIKICAvPgogIAogIDwhLS0gRWFycyAtLT4KICA8cG9seWdvbiBwb2ludHM9Ijc1LDUwIDg1LDE1IDk1LDUwIiBmaWxsPSIjMzQ0OTVlIiAvPgogIDxwb2x5Z29uIHBvaW50cz0iMTI1LDUwIDEzNSwxNSAxNDUsNTAiIGZpbGw9IiMzNDQ5NWUiIC8+CiAgCiAgPCEtLSBIYXBweSBFeWVzIC0tPgogIDxjaXJjbGUgY3g9Ijk1IiBjeT0iNjgiIHI9IjUiIGZpbGw9ImJsYWNrIiAvPgogIDxjaXJjbGUgY3g9IjEyNSIgY3k9IjY4IiByPSI1IiBmaWxsPSJibGFjayIgLz4KICAKICA8IS0tIE5vc2UgLS0+CiAgPGNpcmNsZSBjeD0iMTEwIiBjeT0iOTAiIHI9IjQiIGZpbGw9ImJsYWNrIiAvPgogIAogIDwhLS0gSGFwcHkgTW91dGggKHVwd2FyZCBjdXJ2ZSkgLS0+CiAgPHBhdGggZD0iTTEwMCA5NSBRMTEwIDExMCAxMjAgOTUiIHN0cm9rZT0iIzM0NDk1ZSIgc3Ryb2tlLXdpZHRoPSIzIiBmaWxsPSJub25lIiAvPgo8L3N2Zz4K";
    //string public constant SAD_SVG_URI ="data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSI1MCAxMCAxMDAgMTAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciID4KICA8IS0tIEhlYWQgLS0+CiAgPHBhdGgKICAgIGQ9Ik03MCA3MCBRODAgMzAgMTEwIDQwIFExNDAgMzAgMTQwIDcwIFExMzAgOTAgMTEwIDk1IFE5MCA5NSA3MCA3MCBaIgogICAgZmlsbD0iIzkwYTRhZSIKICAgIHN0cm9rZT0iIzM0NDk1ZSIKICAgIHN0cm9rZS13aWR0aD0iMyIKICAvPgogIAogIDwhLS0gRWFycyAtLT4KICA8cG9seWdvbiBwb2ludHM9Ijc1LDUwIDg1LDE1IDk1LDUwIiBmaWxsPSIjMzQ0OTVlIiAvPgogIDxwb2x5Z29uIHBvaW50cz0iMTI1LDUwIDEzNSwxNSAxNDUsNTAiIGZpbGw9IiMzNDQ5NWUiIC8+CiAgCiAgPCEtLSBTYWQgRXllcyAoZWxsaXB0aWNhbCwgc2xpZ2h0bHkgdGlsdGVkIGRvd253YXJkKSAtLT4KICA8ZWxsaXBzZSBjeD0iOTUiIGN5PSI3MiIgcng9IjUiIHJ5PSIzLjUiIGZpbGw9ImJsYWNrIiB0cmFuc2Zvcm09InJvdGF0ZSgtMTUgOTUgNzIpIiAvPgogIDxlbGxpcHNlIGN4PSIxMjUiIGN5PSI3MiIgcng9IjUiIHJ5PSIzLjUiIGZpbGw9ImJsYWNrIiB0cmFuc2Zvcm09InJvdGF0ZSgxNSAxMjUgNzIpIiAvPgogIAogIDwhLS0gTm9zZSAtLT4KICA8Y2lyY2xlIGN4PSIxMTAiIGN5PSI5MCIgcj0iNCIgZmlsbD0iYmxhY2siIC8+CiAgCiAgPCEtLSBTYWQgTW91dGggKGRvd253YXJkIGN1cnZlKSAtLT4KICA8cGF0aCBkPSJNMTAwIDEwNSBRMTEwIDk1IDEyMCAxMDUiIHN0cm9rZT0iIzM0NDk1ZSIgc3Ryb2tlLXdpZHRoPSIzIiBmaWxsPSJub25lIiAvPgo8L3N2Zz4K";

    address public USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    function testGetHappySVG() public view {
        string memory happySvg = moodNft.getHappySVG();
        assertEq(happySvg, HAPPY_SVG_URI, "Happy SVG URI should match");
    }

    function testGetSadSVG() public view {
        string memory sadSvg = moodNft.getSadSVG();
        assertEq(sadSvg, SAD_SVG_URI, "Sad SVG URI should match");
    }

    function testGetTokenCounter() public {
        uint256 initialCounter = moodNft.getTokenCounter();
        assertEq(initialCounter, 0, "Initial token counter should be 0");

        vm.prank(USER);
        moodNft.mintNft();

        uint256 counterAfterMint = moodNft.getTokenCounter();
        assertEq(counterAfterMint, 1, "Token counter should be 1 after minting");
    }
}

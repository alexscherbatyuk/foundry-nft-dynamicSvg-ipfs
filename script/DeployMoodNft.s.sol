//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft moodNft;

    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad-blue.svg");
        string memory happySvg = vm.readFile("./img/happy-blue.svg");
        console.log(sadSvg);

        vm.startBroadcast();
        moodNft = new MoodNft(svgToImageURI(sadSvg), svgToImageURI(happySvg));
        vm.stopBroadcast();
        console.log(svgToImageURI(sadSvg));
        console.log(svgToImageURI(sadSvg));
        return moodNft;
    }

    function svgToImageURI(string memory _svg) public pure returns (string memory) {
        // example:
        // <svg viewBox="50 10 100 100" xmlns="http://www.w3.org/2000/svg" >
        // data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsImRlc2
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))));
        // string.concat is slightly more gas efficient than abi.encodePacked
        // abi.encodePacked - good for general purposes
        // string.concat - better for string concatination
        return string.concat(baseURI, svgBase64Encoded);
    }
}

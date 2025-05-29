// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract MoodNftIntegrationTest is Test {
    MoodNft moodNft;
    DeployMoodNft deployer;

    string public constant SAD_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsImRlc2NyaXB0aW9uIjoiQSBjb2xsZWN0aW9uIG9mIDEwMDAgQXVzdHJhbGlhbiBDYXR0bGUgRG9ncyBvciBzaW1wbHkgQmx1ZXMuIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsInZhbHVlIjogIjEwMCJ9XSwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0kxTUNBeE1DQXhNREFnTVRBd0lpQjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlENEtJQ0E4SVMwdElFaGxZV1FnTFMwK0NpQWdQSEJoZEdnS0lDQWdJR1E5SWswM01DQTNNQ0JST0RBZ016QWdNVEV3SURRd0lGRXhOREFnTXpBZ01UUXdJRGN3SUZFeE16QWdPVEFnTVRFd0lEazFJRkU1TUNBNU5TQTNNQ0EzTUNCYUlnb2dJQ0FnWm1sc2JEMGlJemt3WVRSaFpTSUtJQ0FnSUhOMGNtOXJaVDBpSXpNME5EazFaU0lLSUNBZ0lITjBjbTlyWlMxM2FXUjBhRDBpTXlJS0lDQXZQZ29nSUFvZ0lEd2hMUzBnUldGeWN5QXRMVDRLSUNBOGNHOXNlV2R2YmlCd2IybHVkSE05SWpjMUxEVXdJRGcxTERFMUlEazFMRFV3SWlCbWFXeHNQU0lqTXpRME9UVmxJaUF2UGdvZ0lEeHdiMng1WjI5dUlIQnZhVzUwY3owaU1USTFMRFV3SURFek5Td3hOU0F4TkRVc05UQWlJR1pwYkd3OUlpTXpORFE1TldVaUlDOCtDaUFnQ2lBZ1BDRXRMU0JUWVdRZ1JYbGxjeUFvWld4c2FYQjBhV05oYkN3Z2MyeHBaMmgwYkhrZ2RHbHNkR1ZrSUdSdmQyNTNZWEprS1NBdExUNEtJQ0E4Wld4c2FYQnpaU0JqZUQwaU9UVWlJR041UFNJM01pSWdjbmc5SWpVaUlISjVQU0l6TGpVaUlHWnBiR3c5SW1Kc1lXTnJJaUIwY21GdWMyWnZjbTA5SW5KdmRHRjBaU2d0TVRVZ09UVWdOeklwSWlBdlBnb2dJRHhsYkd4cGNITmxJR040UFNJeE1qVWlJR041UFNJM01pSWdjbmc5SWpVaUlISjVQU0l6TGpVaUlHWnBiR3c5SW1Kc1lXTnJJaUIwY21GdWMyWnZjbTA5SW5KdmRHRjBaU2d4TlNBeE1qVWdOeklwSWlBdlBnb2dJQW9nSUR3aExTMGdUbTl6WlNBdExUNEtJQ0E4WTJseVkyeGxJR040UFNJeE1UQWlJR041UFNJNU1DSWdjajBpTkNJZ1ptbHNiRDBpWW14aFkyc2lJQzgrQ2lBZ0NpQWdQQ0V0TFNCVFlXUWdUVzkxZEdnZ0tHUnZkMjUzWVhKa0lHTjFjblpsS1NBdExUNEtJQ0E4Y0dGMGFDQmtQU0pOTVRBd0lERXdOU0JSTVRFd0lEazFJREV5TUNBeE1EVWlJSE4wY205clpUMGlJek0wTkRrMVpTSWdjM1J5YjJ0bExYZHBaSFJvUFNJeklpQm1hV3hzUFNKdWIyNWxJaUF2UGdvOEwzTjJaejRLIn0=";
    string public constant HAPPY_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsImRlc2NyaXB0aW9uIjoiQSBjb2xsZWN0aW9uIG9mIDEwMDAgQXVzdHJhbGlhbiBDYXR0bGUgRG9ncyBvciBzaW1wbHkgQmx1ZXMuIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsInZhbHVlIjogIjEwMCJ9XSwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0kxTUNBeE1DQXhNREFnTVRBd0lpQjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlENEtJQ0E4SVMwdElFaGxZV1FnTFMwK0NpQWdQSEJoZEdnS0lDQWdJR1E5SWswM01DQTNNQ0JST0RBZ016QWdNVEV3SURRd0lGRXhOREFnTXpBZ01UUXdJRGN3SUZFeE16QWdPVEFnTVRFd0lEazFJRkU1TUNBNU5TQTNNQ0EzTUNCYUlnb2dJQ0FnWm1sc2JEMGlJemt3WVRSaFpTSUtJQ0FnSUhOMGNtOXJaVDBpSXpNME5EazFaU0lLSUNBZ0lITjBjbTlyWlMxM2FXUjBhRDBpTXlJS0lDQXZQZ29nSUFvZ0lEd2hMUzBnUldGeWN5QXRMVDRLSUNBOGNHOXNlV2R2YmlCd2IybHVkSE05SWpjMUxEVXdJRGcxTERFMUlEazFMRFV3SWlCbWFXeHNQU0lqTXpRME9UVmxJaUF2UGdvZ0lEeHdiMng1WjI5dUlIQnZhVzUwY3owaU1USTFMRFV3SURFek5Td3hOU0F4TkRVc05UQWlJR1pwYkd3OUlpTXpORFE1TldVaUlDOCtDaUFnQ2lBZ1BDRXRMU0JJWVhCd2VTQkZlV1Z6SUMwdFBnb2dJRHhqYVhKamJHVWdZM2c5SWprMUlpQmplVDBpTmpnaUlISTlJalVpSUdacGJHdzlJbUpzWVdOcklpQXZQZ29nSUR4amFYSmpiR1VnWTNnOUlqRXlOU0lnWTNrOUlqWTRJaUJ5UFNJMUlpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQUtJQ0E4SVMwdElFNXZjMlVnTFMwK0NpQWdQR05wY21Oc1pTQmplRDBpTVRFd0lpQmplVDBpT1RBaUlISTlJalFpSUdacGJHdzlJbUpzWVdOcklpQXZQZ29nSUFvZ0lEd2hMUzBnU0dGd2NIa2dUVzkxZEdnZ0tIVndkMkZ5WkNCamRYSjJaU2tnTFMwK0NpQWdQSEJoZEdnZ1pEMGlUVEV3TUNBNU5TQlJNVEV3SURFeE1DQXhNakFnT1RVaUlITjBjbTlyWlQwaUl6TTBORGsxWlNJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWlCbWFXeHNQU0p1YjI1bElpQXZQZ284TDNOMlp6NEsifQ==";

    string public constant SAD_TOKEN_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsImRlc2NyaXB0aW9uIjoiQSBjb2xsZWN0aW9uIG9mIDEwMDAgQXVzdHJhbGlhbiBDYXR0bGUgRG9ncyBvciBzaW1wbHkgQmx1ZXMuIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsInZhbHVlIjogIjEwMCJ9XSwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0kxTUNBeE1DQXhNREFnTVRBd0lpQjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlENEtJQ0E4SVMwdElFaGxZV1FnTFMwK0NpQWdQSEJoZEdnS0lDQWdJR1E5SWswM01DQTNNQ0JST0RBZ016QWdNVEV3SURRd0lGRXhOREFnTXpBZ01UUXdJRGN3SUZFeE16QWdPVEFnTVRFd0lEazFJRkU1TUNBNU5TQTNNQ0EzTUNCYUlnb2dJQ0FnWm1sc2JEMGlJemt3WVRSaFpTSUtJQ0FnSUhOMGNtOXJaVDBpSXpNME5EazFaU0lLSUNBZ0lITjBjbTlyWlMxM2FXUjBhRDBpTXlJS0lDQXZQZ29nSUFvZ0lEd2hMUzBnUldGeWN5QXRMVDRLSUNBOGNHOXNlV2R2YmlCd2IybHVkSE05SWpjMUxEVXdJRGcxTERFMUlEazFMRFV3SWlCbWFXeHNQU0lqTXpRME9UVmxJaUF2UGdvZ0lEeHdiMng1WjI5dUlIQnZhVzUwY3owaU1USTFMRFV3SURFek5Td3hOU0F4TkRVc05UQWlJR1pwYkd3OUlpTXpORFE1TldVaUlDOCtDaUFnQ2lBZ1BDRXRMU0JJWVhCd2VTQkZlV1Z6SUMwdFBnb2dJRHhqYVhKamJHVWdZM2c5SWprMUlpQmplVDBpTmpnaUlISTlJalVpSUdacGJHdzlJbUpzWVdOcklpQXZQZ29nSUR4amFYSmpiR1VnWTNnOUlqRXlOU0lnWTNrOUlqWTRJaUJ5UFNJMUlpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQUtJQ0E4SVMwdElFNXZjMlVnTFMwK0NpQWdQR05wY21Oc1pTQmplRDBpTVRFd0lpQmplVDBpT1RBaUlISTlJalFpSUdacGJHdzlJbUpzWVdOcklpQXZQZ29nSUFvZ0lEd2hMUzBnU0dGd2NIa2dUVzkxZEdnZ0tIVndkMkZ5WkNCamRYSjJaU2tnTFMwK0NpQWdQSEJoZEdnZ1pEMGlUVEV3TUNBNU5TQlJNVEV3SURFeE1DQXhNakFnT1RVaUlITjBjbTlyWlQwaUl6TTBORGsxWlNJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWlCbWFXeHNQU0p1YjI1bElpQXZQZ284TDNOMlp6NEsifQ==";

    address public USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    /*//////////////////////////////////////////////////////////////
                      INTEGRATION MOOD NFT TESTING
    //////////////////////////////////////////////////////////////*/

    function testViewTokenURIIntegration() public {
        // Arrange
        vm.prank(USER);

        // Act
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));

        // Assert
        assertEq(moodNft.tokenURI(0), SAD_TOKEN_URI);
    }

    function testFlipTokenToSad() public {
        // Arrange / Act
        vm.startPrank(USER);
        moodNft.mintNft();
        moodNft.flipMood(0);
        vm.stopPrank();

        // Assert
        assert(keccak256(abi.encodePacked(moodNft.tokenURI(0))) == keccak256(abi.encodePacked(SAD_SVG_URI)));
    }

    function testFlipTokenToHappy() public {
        // Arrange / Act
        vm.startPrank(USER);
        moodNft.mintNft();
        moodNft.flipMood(0);
        moodNft.flipMood(0);
        vm.stopPrank();

        // Assert
        assert(keccak256(abi.encodePacked(moodNft.tokenURI(0))) == keccak256(abi.encodePacked(HAPPY_SVG_URI)));
    }

    function testFlipTokenRevertWhenNotOwner() public {
        // Arrange
        vm.prank(USER);

        // Act
        moodNft.mintNft();

        // Assert
        vm.expectRevert(MoodNft.MoodNft__CantFlipMoodIfNotOwner.selector);
        moodNft.flipMood(0);
    }
}

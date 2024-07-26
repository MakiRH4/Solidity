// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ExampleContract{
    function encodingXY(uint x, uint256 y) public pure returns (bytes memory) {
        return abi.encode(x,y);
    }
    
    function getATuple(bytes memory encoding) public pure returns (uint256, uint256) {
        (uint256 x, uint256 y) = abi.decode(encoding, (uint256, uint256));
        return(x,y);
    }
}
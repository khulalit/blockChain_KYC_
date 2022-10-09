// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

library UtilityFunction {

    function append(string memory a, string memory b) public pure returns (string memory) {

        return string(abi.encodePacked(a, b));

    }
    function isEqual(string memory a, string memory b) public pure returns(bool)  {
        // Compare string keccak256 hashes to check equality
        if (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b))) 
            return true;
        return false;
    }
}

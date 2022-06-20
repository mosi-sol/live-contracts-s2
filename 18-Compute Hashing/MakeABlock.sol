// SPDX-License-Identifier: MIT
pragma solidity 0.8;

/// @dev learning about: state and local variable by how to hook functions, and hashing
contract MakeABlock {
    uint public i;

    function makeABlock(uint j) public returns (bytes32) {
        i += j;
        return blockData();
    }

    function blockData() public view returns (bytes32) {
        return bytes32(keccak256(abi.encodeWithSignature("makABlock(uint256)", i)));
    }
}

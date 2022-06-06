// SPDX-License-Identifier: MIT
pragma solidity 0.8;

/// @dev https://eips.ethereum.org/EIPS/eip-3722

// interface
interface IPoster {

    event NewPost(address indexed user, string content, string indexed tag);

    function post(string calldata content, string calldata tag) external;
}

// usual
contract Poster {

    event NewPost(address indexed user, string content, string indexed tag);

    function post(string calldata content, string calldata tag) public {
        emit NewPost(msg.sender, content, tag);
    }
}

// follow the terms
contract Poster is IPoster {

    function post(string calldata content, string calldata tag) public override {
        emit NewPost(msg.sender, content, tag);
    }
}

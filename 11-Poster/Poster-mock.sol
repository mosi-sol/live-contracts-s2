// SPDX-License-Identifier: MIT
pragma solidity 0.8;

/// @dev https://eips.ethereum.org/EIPS/eip-3722
interface IPoster {
    event NewPost(address indexed user, string content, string indexed tag);
    function post(string calldata content, string calldata tag) external returns (uint);
}

contract Poster is IPoster {

    mapping(address => uint) private creators; // who -> id`s
    uint postId = 0;

    function post(string calldata content, string calldata tag) external override returns (uint) {
        _post(content, tag);
        return postId;
    }

    // logic
    function _post(string calldata content, string calldata tag) internal {
        emit NewPost(msg.sender, content, tag);
        postId += 1;
        creators[msg.sender] = postId;
    }

}

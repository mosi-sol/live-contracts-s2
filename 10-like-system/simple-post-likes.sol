// SPDX-License-Identifier: MIT
pragma solidity 0.8;

contract LikeCounter {
    mapping(uint => mapping(address => bool)) likes; // post id -> account -> is voted
    mapping(uint => int) summary; // post id -> [+] & [-]

    uint postId;

    constructor() {
        postId = 0;
        postNew();
        postNew();
        postNew();
    }

    function postNew() internal {
        postId += 1;
        summary[postId] = 0;
    }

    function inc(uint _postId) external {
        require(_postId > 0 && _postId <= postId, "this post not exist");
        require(likes[_postId][msg.sender] == false, "youre liked/disliked");
        likes[_postId][msg.sender] = true;
        summary[_postId] += 1;
    }

    function dec(uint _postId) external {
        require(_postId > 0 && _postId <= postId, "this post not exist");
        require(likes[_postId][msg.sender] == false, "youre liked/disliked");
        likes[_postId][msg.sender] = true;
        summary[_postId] -= 1;
    }

    function total(uint _postId) external view returns (int) {
        return summary[_postId];
    }
}

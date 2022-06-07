// SPDX-License-Identifier: MIT
pragma solidity 0.8;

/// @dev https://eips.ethereum.org/EIPS/eip-3722
interface IPoster {
    event NewPost(address indexed user, string content, string indexed tag);
    function post(string calldata content, string calldata tag) external returns (uint);
}

contract BlogByPoster is IPoster {

    mapping(uint => address) private creators; // who -> id`s
    uint postId;
    string blogName;

    event Who(uint indexed id, address creator);
    event Tips(uint indexed id, address sender, address recipiant);

    constructor(
        string memory _blogName, 
        uint _postId) {
            postId = _postId;
            blogName = _blogName;
        }

    function post(string calldata content, string calldata tag) external override returns (uint) {
        _post(content, tag);
        return postId;
    }

    function who(uint id) external returns (address) {
        _who(id);
        return creators[id];
    }

    // logic
    function _post(string calldata content, string calldata tag) internal {
        emit NewPost(msg.sender, content, tag);
        postId += 1;
        creators[postId] = msg.sender;
    }

    function _who(uint id) internal {
        require(id > 0 && id <= postId, "Invalid post id");
        address ownerOf = creators[id];
        emit Who(id, ownerOf);
    }

    // financial (tips)
    function tips(uint256 _id) external payable {
        require(_id > 0 && _id <= postId, "Invalid post id");
        address _ownerOf = creators[_id];
        require(_ownerOf != msg.sender, "Cannot tip your own post");
        payable(_ownerOf).transfer(msg.value); // not usully use transfer, but this is training video
        emit Tips(_id, msg.sender, _ownerOf);
    }

}

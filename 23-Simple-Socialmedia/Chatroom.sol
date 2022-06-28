// SPDX-License-Identifier: MIT
pragma solidity 0.8;

/*
@title: simple social media, look like a chat room.
@dev: stringToBytes() AND bytesToString() use for test. in frontend you can use ethersjs for this goal.
@info: in frontend change bytes to string OR string to bytes has no cost for transaction.
*/

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IIssueTrakable is IERC165 {
    event NewIssue(address indexed from, uint256 indexed tokenId, uint256 time);
    event SolvedIssue(address indexed solvedBy, uint256 indexed tokenId, uint256 time);

    function ask(bytes calldata data) external returns (uint256 tokenId);
    function answer(uint256 tokenId, bytes calldata data) external returns (uint256 tokenId_, bool solved);
}

contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) external virtual override view returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

contract IssueTrakable is ERC165, IIssueTrakable {
    address private owner_;

    uint private _tokenId;
    mapping(uint => mapping(bytes => bool)) private _issues; // id -> data -> isSolved
    mapping(uint => address) private _asked; // id -> sender
    mapping(uint => address) private _answered; // id -> answer the issue/requst/ask

    // ****************************************************** \\
    /// Error IssueTrakable: Transaction failed!
    error errorMessage();

    // ****************************************************** \\
    constructor() {
        _tokenId = 0;
    }

    // ****************************************************** \\
    function supportsInterface(bytes4 interfaceId) external virtual override(ERC165, IERC165) view returns (bool) {
        return interfaceId == type(IERC165).interfaceId || 
        interfaceId == type(IIssueTrakable).interfaceId;
    }

    // ****************************************************** \\ virtual override
    function ask(bytes calldata data) 
    external virtual override returns (uint256 tokenId) {
        _tokenId += 1;
        _issues[_tokenId][data] = false;
        _asked[_tokenId] = _msgSender();
        emit NewIssue(_msgSender(), _tokenId, block.timestamp);
        tokenId = _tokenId;
    }
    
    function answer(uint256 tokenId, bytes calldata data) 
    external virtual override returns (uint256 tokenId_, bool solved){
        require(tokenId <= _tokenId, "not request find.");
        _issues[tokenId][data] = true;
        _answered[tokenId] = _msgSender();
        emit SolvedIssue(_msgSender(), tokenId, block.timestamp);
        (tokenId_, solved) = (tokenId, true);
    }

    // libs ----------------------------------
    function stringToBytes(string calldata listener) external pure returns (bytes memory encryption) {
        encryption = bytes(abi.encode(listener));
    }
    
    function bytesToString(bytes calldata sniffer) external pure returns (string memory decryption) {
        decryption = abi.decode(sniffer, (string));
    }

    // ****************************************************** \\
    // libs ----------------------------------
    function _this() internal view virtual returns (address) {
        return address(this);
    }

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }  

    function _owner() internal view virtual returns (address) {
        return owner_;
    }

    // ****************************************************** \\
    modifier onlyOwner() {
        require(_owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
}

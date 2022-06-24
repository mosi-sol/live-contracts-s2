// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ITrackable is IERC165 {
    // function supportsInterface(bytes4 interfaceId) external virtual override view returns (bool);
    function track(address token, uint tokenId) external returns (address, uint);
}

contract Trackable is ITrackable, ERC165 {
    // variables ----------------------------------
    IERC721 private _NFT; // _NFT = IERC721(address);
    mapping(address => mapping(address => uint)) private _registredToken; // actor -> token address -> token id

    // events ----------------------------------
    event Tracked(address owner, uint cash);

    // modifiers ----------------------------------

    // init ----------------------------------
    constructor() {

    }

    // helpers ----------------------------------
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(ITrackable).interfaceId || super.supportsInterface(interfaceId);
    }

    // calculation ----------------------------------
    function track(address token, uint tokenId) public virtual override returns (address, uint) {
        _NFT = IERC721(token);
        address _owner = _NFT.ownerOf(tokenId);
        uint _val = _owner.balance;
        emit Tracked(_owner, _val);
        return (_owner, _val);
    }

    // logics ----------------------------------
    

}

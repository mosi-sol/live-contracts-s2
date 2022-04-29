// SPDX-License-Identifier: MIT
pragma solidity 0.8;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NftWallet is Ownable{

    struct List{
        uint id;
        bool isListed;
        address nft;
        uint price;
        uint listId;
    }
    List[] list;
    uint listId = 1;

    event RecieveNFT();
    event ListNFT();
    event SellNFT();
   

    function reciveNft(address _nft, uint _id) external returns (bool result) {
        result = _reciveNft(_nft, _id);
        if(result == true){
            emit RecieveNFT();
        }
    }

    function listNft(address _nft, uint _id, uint price) external returns (bool result) {
        result = _listNft(_nft, _id, price);
        if(result == true){
            emit ListNFT();
        }
    }

    function buy(uint _id, uint _listId, uint _price) payable external returns (bool result) {
        result = _buy(_id, _listId, _price);
        if(result == true){
            emit SellNFT();
        }
    }

    // --- LOGICS --- \\
    function _reciveNft(address _nft, uint _id) internal returns (bool result) {
        require(msg.sender == ERC721(_nft).ownerOf(_id), "only real owner");
        ERC721(_nft).approve(address(this), _id);
        ERC721(_nft).safeTransferFrom(msg.sender, address(this), _id);
        result = true;
    }

    function _listNft(address _nft, uint _id, uint price) internal returns (bool result) {
        require(ERC721(_nft).ownerOf(_id) == msg.sender, "nft owner is avalibale for listing");
        require(list[_id].isListed == false, "this item listed");
        list.push(List(_id, true, _nft, price, listId));
        listId += 1;
        result = true;
    }

    function _buy(uint _id, uint _listId, uint _price) internal returns (bool) { // payable
        require(list[_id].isListed == true, "not listed item");
        require(list[_id].listId == _listId, "not exict");
        if(_price >= list[_id].price){
            ERC721(list[_id].nft).safeTransferFrom(address(this), msg.sender, _id);
            return true;
        }
        return false;
    }

    receive() payable external{}
}


// --------------------------------------------------
// after mint, approve NftWallet smartcontract address
contract NftTest is ERC721 {
    uint id = 1;
    constructor() ERC721("test","TST"){
        _mint(msg.sender, id);
        id += 1;
    }
    
    function mint() external{
        _mint(msg.sender, id);
        id += 1;
    }
}

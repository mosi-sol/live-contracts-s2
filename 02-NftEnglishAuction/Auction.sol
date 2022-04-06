// SPDX-License-Identifier: MIT
pragma solidity 0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Receiver.sol";
// security
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol";
// lib
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Timers.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

contract AuctionNFT is Ownable, ReentrancyGuard {
    using Address for address payable;
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter; // uint256 Id = _idCounter.current(); _idCounter.increment();
    
    //--------------------------------------

    IERC721 public nft;
    address payable public seller;
    address public highestBidder;
    uint public nftId;
    uint public endAt;
    uint public highestBid;
    bool public started;
    bool public ended;
    mapping(address => uint) public bids;

    //--------------------------------------

    event Start(uint auctionID);
    event Bid(uint auctionID, address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(uint auctionID, address indexed winner, uint amount);

    //--------------------------------------

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    //--------------------------------------

    // exacutions
    function startAuction() external onlyOwner returns (bool successStart) {
        successStart = _startAuction();
    }

    function bid() external payable returns (bool successBid) {
        successBid = _bid();
    }

    function end() external onlyOwner returns (bool successEnd) {
        successEnd = _end();
    }

    //--------------------------------------

    // logics
    function _startAuction() internal returns (bool) {
        require(!started, "started");
        require(msg.sender == seller, "not seller"); // walletOfOwner(address) => seller
        nft.transferFrom(msg.sender, address(this), nftId);
        started = true;
        endAt = block.timestamp + 2 days; // 7 days is a very famous type for artists :)
        _idCounter.increment();
        emit Start(_idCounter.current());
        return true;
    }

    function _bid() internal returns (bool) {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest");
        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit Bid(_idCounter.current(), msg.sender, msg.value);
        return true;
    }

    function _end() internal returns (bool) {
        require(started, "not started");
        require(block.timestamp >= endAt, "not ended");
        require(!ended, "ended");
        ended = true;
        if (highestBidder != address(0)) {
            nft.safeTransferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            nft.safeTransferFrom(address(this), seller, nftId);
        }
        emit End(_idCounter.current(), highestBidder, highestBid);
        return true;
    }

    //--------------------------------------

    // withdraw
    function withdraw() external nonReentrant {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        // (sent, ) = msg.sender.call{value: bal}("");
        // require(sent);
        emit Withdraw(msg.sender, bal);
    }

    //--------------------------------------
    
    // NFT HOLDER
    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual returns (bytes4) {
        return this.onERC721Received.selector;
    }

    // for testing this, you will need erc721 contract like -> https://github.com/mosi-sol/erc721/tree/main/v5
}

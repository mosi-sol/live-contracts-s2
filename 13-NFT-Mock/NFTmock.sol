// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract NFT is IERC165, ERC721Royalty, Pausable, Ownable, ReentrancyGuard { 
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    string public uriPrefix = "_CID_";
    string public uriSuffix = ".json";
    uint256 public maxSupply;
    uint256 private price;
    mapping(uint256 => uint256) public thePrice; // tokenId -> price [airdrop = 0]

    constructor(
        uint256 _maxSupply, 
        uint256 _price, 
        uint96 _royality,
        string memory _uriPrefix
        ) 
    ERC721("NFT BASE", "NFTB") {
        maxSupply = _maxSupply;
        price = _price;
        uriPrefix = _uriPrefix;
        setDefaultRoyalty(msg.sender, _royality);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function airdropMint(address to) public onlyOwner whenNotPaused {
        require(uint256(_tokenIdCounter.current()) < maxSupply, "mint finish");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function safeMint(address to) payable public whenNotPaused {
        require(uint256(_tokenIdCounter.current()) < maxSupply, "mint finish");
        require(msg.value >= price,"abda says: money money money!");
        uint256 tokenId = _tokenIdCounter.current();
        // _tokenIdCounter.increment();
        thePrice[tokenId] = price;
        _safeMint(to, tokenId);
    }

    function burn(uint256 tokenId) public {
        _burn(tokenId);
    }

    function setCost(uint256 _newCost) public onlyOwner {
        price = _newCost;
    }

    // royality
    function setTokenRoyalty(
        uint256 tokenId,
        address recipient,
        uint96 fraction
    ) public {
        _setTokenRoyalty(tokenId, recipient, fraction);
    }

    function setDefaultRoyalty(address recipient, uint96 fraction) public {
        _setDefaultRoyalty(recipient, fraction);
    }
    
    function deleteDefaultRoyalty() public {
        _deleteDefaultRoyalty();
    }
    // royality end

    // uri
    function tokenURI(uint256 _tokenId)
        public view virtual override returns (string memory) {
        require(_exists(_tokenId),
        "ERC721Metadata: URI query for nonexistent token"
        );

        string memory gateway = "ipfs://";
        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(gateway, currentBaseURI, "/", _tokenId.toString(), uriSuffix))
            : "";
    }

    function setUriPrefix(string memory _uriPrefix) public onlyOwner {
        uriPrefix = _uriPrefix;
    }

    function setUriSuffix(string memory _uriSuffix) public onlyOwner {
        uriSuffix = _uriSuffix;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return uriPrefix; // set/put "cidHashHere" from setUriPrefix()
    }
    // uri end

    // erc20 recomendation
    function withdraw() payable public onlyOwner nonReentrant {
        (bool success, ) = payable(owner()).call{value: address(this).balance}("");
        require(success);
    }

    receive() external payable {}

    fallback() external payable {}

    function balanceOf20() view public returns(uint) {
        return address(this).balance;
    }
    // erc20 end

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

}

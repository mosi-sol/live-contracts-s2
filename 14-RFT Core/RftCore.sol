// SPDX-License-Identifier: MIT
pragma solidity 0.8;

contract RFT_Share_Core {

	mapping(address => mapping(uint => uint)) ownerToTokenShare;
	mapping(uint => mapping(address => uint)) tokenToOwnersHoldings;
	mapping(uint => bool) mintedToken;
	uint public divisibility = 1000; 
	uint public totalSupply;

	modifier onlyNonExistentToken(uint _tokenId) {
	    require(mintedToken[_tokenId] == false);
	    _;
	}

	modifier onlyExistentToken(uint _tokenId) {
	    require(mintedToken[_tokenId] == true);
	    _;
	}

    event Minted(address owner, uint tokenId);
    event Transfered(address owner, address recipient, uint tokenId, uint shares);

	function unitsOwnedOfAToken(address _owner, uint _tokenId) public view returns (uint _balance)
	{
	    return ownerToTokenShare[_owner][_tokenId];
	}

	function mint(address _owner, uint _tokenId) public onlyNonExistentToken (_tokenId)
	{	
		mintedToken[_tokenId] = true;
		_addShareToNewOwner(_owner, _tokenId, divisibility); 
		_addNewOwnerHoldingsToToken(_owner, _tokenId, divisibility);
		totalSupply = totalSupply + 1;
		emit Minted(_owner, _tokenId); 
	}

	function transfer(address _to, uint _tokenId, uint _units) public onlyExistentToken (_tokenId)
	{
		require(ownerToTokenShare[msg.sender][_tokenId] >= _units);
		_removeShareFromLastOwner(msg.sender, _tokenId, _units);
		_removeLastOwnerHoldingsFromToken(msg.sender, _tokenId, _units);
		_addShareToNewOwner(_to, _tokenId, _units);
		_addNewOwnerHoldingsToToken(_to, _tokenId, _units);
		emit Transfered(msg.sender, _to, _tokenId, _units); 
	}
	

	// Helpers

	// Remove token units from last owner
	function _removeShareFromLastOwner(address _owner, uint _tokenId, uint _units) private
	{
		ownerToTokenShare[_owner][_tokenId] -= _units;
	}

	// Add token units to new owner
	function _addShareToNewOwner(address _owner, uint _tokenId, uint _units) private
	{
		ownerToTokenShare[_owner][_tokenId] += _units;
	}

	// Remove units from last owner 
	function _removeLastOwnerHoldingsFromToken(address _owner, uint _tokenId, uint _units) private
	{
		tokenToOwnersHoldings[_tokenId][_owner] -= _units;
	}

	// Add the units to new owner
	function _addNewOwnerHoldingsToToken(address _owner, uint _tokenId, uint _units) private
	{
		tokenToOwnersHoldings[_tokenId][_owner] += _units;
	}
}

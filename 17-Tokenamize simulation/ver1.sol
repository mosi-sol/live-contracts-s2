// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

interface ITokenamize{
	event Born(uint id);
	event Burn(uint id);
	event Transfer(uint id);
	function theOwner(address who) view external returns (uint);
	function isOwner(address who) view external returns (bool);
	function total() view external returns (uint);
	function born() external returns (uint);
	function burn() external returns (uint);
	function transfer(address recipient) external returns (uint);
}

contract Tokenamize is ITokenamize{
	uint private _id;
	uint private _total;
	mapping(address => uint) private _theOwner;
	mapping(address => bool) private _isOwner;

	constructor() {
		_id = 0;
	}

	function theOwner(address who) view external override returns (uint){
		return _theOwner[who];
	}

	function isOwner(address who) view external override returns (bool){
		return _isOwner[who];
	}

	function total() view external override returns (uint){
		return _total;
	}

	function born() external override returns (uint){
		_born();
		return _id;
	}

	function burn() external override returns (uint){
		_burn();
		return 0;
	}

	function transfer(address recipient) external override returns (uint){
		_transfer(recipient);
		return _theOwner[recipient];
	}
	
	function _born() private {
		require(_isOwner[msg.sender] == false ,"not eligible to create");
		_id += 1;
		_theOwner[msg.sender] = _id;
		_isOwner[msg.sender] = true;
		_total += 1;
	}

	function _burn() private {
		require(_isOwner[msg.sender] == true ,"not have token");
		require(_theOwner[msg.sender] != 0 ,"not have token");
		_theOwner[msg.sender] = 0;
		_isOwner[msg.sender] = false;
		_total -= 1;
	}

	function _transfer(address recipient) private {
		require(_isOwner[msg.sender] == true 
		&& _isOwner[recipient] == false ,"can not transfer");
		require(_theOwner[msg.sender] != 0 
		&& _theOwner[recipient] == 0 ,"can not transfer");
		uint target = _theOwner[msg.sender];
		_theOwner[msg.sender] = 0;
		_isOwner[msg.sender] = false;
		_theOwner[recipient] = target;
		_isOwner[recipient] = true;
	}
}

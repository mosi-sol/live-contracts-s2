// SPDX-License-Identifier: MIT
pragma solidity 0.8;

// model: unique asset
contract TokenamizeAssets_Simulation{
	mapping(address => uint) public theOwner; // public for test, change to private or null
	mapping(address => bool) isOwner;
	uint id;
	uint total;

	constructor() {
		id = 0;
	}

	function born() external returns (uint _id) {
		require(isOwner[msg.sender] == false ,"not eligible to create");
		id += 1;
		theOwner[msg.sender] = id;
		isOwner[msg.sender] = true;
		total += 1;
		_id = id;
	}

	function burn() external returns (uint _id) {
		require(isOwner[msg.sender] == true ,"not have token");
		require(theOwner[msg.sender] != 0 ,"not have token");
		theOwner[msg.sender] = 0;
		isOwner[msg.sender] = false;
		total -= 1;
		_id = 0;
	}

	function transfer(address recipient) external returns (uint _id) {
		require(isOwner[msg.sender] == true 
		&& isOwner[recipient] == false ,"can not transfer");
		require(theOwner[msg.sender] != 0 
		&& theOwner[recipient] == 0 ,"can not transfer");
		uint target = theOwner[msg.sender];
		theOwner[msg.sender] = 0;
		isOwner[msg.sender] = false;
		theOwner[recipient] = target;
		isOwner[recipient] = true;
		_id = target;
	}

}

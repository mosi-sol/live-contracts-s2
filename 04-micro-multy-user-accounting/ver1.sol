// SPDX-License-Identifier: MIT
pragma solidity 0.8;

// import "https://github.com/mosi-sol/erc20/blob/main/easy%20erc20/erc20.sol";

contract MicroMultiBankUser {
    
    address private _owner;
    mapping(address => uint8) private _users; 
    uint private _balance;

    event DepositedBy(address from, uint amount, uint date);
    event WithdrawTo(address to, uint amount, uint date);
    event TransferingTo(address from, address to, uint amount, uint date);
    
    constructor() payable {
        _owner = msg.sender;
        if(msg.value > 0){
            _balance += msg.value;
        }
    }

    modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }
    
    modifier isValidUser() {
        require(msg.sender == _owner || _users[msg.sender] == 1);
        _;
    }
    
    function addOwner(address owner) isOwner external {
        _users[owner] = 1;
    }
    
    function removeOwner(address owner) isOwner external {
        _users[owner] = 0;
    }
    
    fallback () external payable {
        if(msg.value > 0){
            _balance += msg.value;
        }
        emit DepositedBy(msg.sender, msg.value, block.timestamp);
    }

    receive() external payable {
        if(msg.value > 0){
            _balance += msg.value;
        }
        emit DepositedBy(msg.sender, msg.value, block.timestamp);
    }

    function deposit() external payable {
        require(msg.value > 0, "uncle scroch!");
        _balance += msg.value;
        emit DepositedBy(msg.sender, msg.value, block.timestamp);
    }
    
    function transferTo(address to, uint amount) external isValidUser {
        require(address(this).balance >= amount);
        payable(to).transfer(amount);
        _balance -= amount;
        emit TransferingTo(msg.sender, to, amount, block.timestamp);
    }
    
    function withdraw(uint amount) external isValidUser {
        require(address(this).balance >= amount);
        payable(msg.sender).transfer(amount);
        _balance -= amount;
        emit WithdrawTo(msg.sender, amount, block.timestamp);
    }

    function balances() view external returns (uint value) {
        value = _balance;
    }
        
}

// using security for "transferTo" & "withdraw" functions, like (noReentrancy) or (pull before push)
// use "call" better then of "transfer" in more cases
// if you want to know more about security, run deposit function & find the bug & fix it

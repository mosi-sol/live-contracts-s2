// SPDX-License-Identifier: MIT
pragma solidity 0.8;

contract EtherWallet {
    address payable public owner;

    IERC20 token;
    uint256 private customTokenAmount;

    constructor(address _token) {
        owner = payable(msg.sender);
        token = IERC20(_token);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not owner");
        _;
    }

    receive() external payable {}

    function withdraw(uint _amount) external onlyOwner {
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    // IERC20 TOKEN
    function receiveToken(uint _amount) external payable {
        // a rquire to owne/sender have amount
        // token.increaseAllowance(address(this), _amount); // handle
        token.approve(address(this), _amount);
        token.transferFrom(msg.sender, address(this), _amount);
        customTokenAmount += _amount;
    }

    function withdrawToken() external onlyOwner {
        uint256 tmp = customTokenAmount;
        customTokenAmount = 0;
        token.transfer(msg.sender, tmp);
    }

    function getBalanceToken() external view returns (uint) { // mapping
        return customTokenAmount;
    }
    
    // not use function changeToken, if you not withdraw
    function changeToken(address _token) external onlyOwner {
        customTokenAmount = 0;
        token = IERC20(_token);
    }
}




interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


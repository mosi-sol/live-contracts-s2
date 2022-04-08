// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/mosi-sol/erc20/blob/main/IERC20.sol";

contract SimpleStaking {

  mapping(address => mapping(address => uint)) private _balances;
  
  function staking(address token, uint amount) external returns(bool) {
    _balances[msg.sender][token] += amount;
    bool success = IERC20(token).transferFrom(msg.sender, address(this), amount);
    if(!success) revert("error back");
    return success;
  }
}


// deploy this token for test
import "https://github.com/mosi-sol/erc20/blob/main/from%20scratch/ERC20.sol";
contract TestToken is ERC20   {
    constructor(string memory _name, string memory _symbol, uint8 _decimals) 
    ERC20  (_name, _symbol, _decimals) {
        _mint(1000);
    }
}

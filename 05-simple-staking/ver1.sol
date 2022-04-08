// SPDX-License-Identifier: MIT
pragma solidity 0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleStaking {

  mapping(address => mapping(address => uint)) private _balances;
  
  function staking(address token, uint amount) external returns(bool success) {
      success = _staking(token, amount);
  }

  function _staking(address token, uint amount) internal returns(bool) {
    _balances[msg.sender][token] += amount;
    bool success = IERC20(token).transferFrom(msg.sender, address(this), amount);
    if(!success) revert("error back");
    return success;
  }
}


// deploy this token for test
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract TestToken is ERC20 {
    constructor(string memory _name, string memory _symbol) 
    ERC20(_name, _symbol) {
        _mint(msg.sender, 1000000000000000000000);
    }
}
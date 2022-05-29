// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Standard is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        // mint some token
    }
    
    // check amount < minted
    // check address hasExist
     function batchTransfer(address[] calldata _toList, uint256[] calldata _amounts) external returns (uint) {
        for (uint256 i = 0; i < _toList.length; i++) {
            transfer(_toList[i], _amounts[i]);
        }
        return _toList.length;
    }

}

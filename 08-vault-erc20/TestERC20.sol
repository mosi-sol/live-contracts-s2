// SPDX-License-Identifier: MIT
pragma solidity 0.8;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Standard is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, 1000);
    }
    function mint() external{
        _mint(msg.sender, 2000);
    }
}

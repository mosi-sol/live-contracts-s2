// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/mosi-sol/erc20/blob/main/IERC20.sol";

contract TranslateSolution is IERC20 {
    // bytes calls;
    function translate(address recipients, uint amounts) external pure returns (bytes memory calls) {
        // bytes memory calls = new bytes;
        calls = abi.encodeWithSignature("transfer(address,uint256)", recipients, amounts);
    }

    function decrypt(bytes memory sign) external pure returns (address ad, uint un) {
        (ad, un) = abi.decode(sign, (address, uint));
    }

    function totalSupply() external view returns (uint){}
    function balanceOf(address account) external view returns (uint){}
    function transfer(address recipient, uint amount) external returns (bool){}
    function allowance(address owner, address spender) external view returns (uint){}
    function approve(address spender, uint amount) external returns (bool){}
    function transferFrom(address sender, address recipient, uint amount) external returns (bool){}
}

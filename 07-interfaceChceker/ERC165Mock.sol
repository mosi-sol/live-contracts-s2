// SPDX-License-Identifier: MIT

pragma solidity 0.8;

import './IERC165.sol';

contract ERC165 is IERC165 {
  mapping(bytes4 => bool) private _supportedInterfaces;
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return _supportedInterfaces[interfaceId];
    }
    
    function testHelper() public vieew returns (bytes4) {
        return bytes4(keccak256('supportsInterface(bytes4)'));
    }
    
    function registerHelper(bytes4 interfaceId) public {
        require(interfaceId != 0xffffffff, "not validated interfaceId");
        _supportedInterfaces[interfaceId] = true;
    }
}

// SPDX-License-Identifier: MIT

pragma solidity 0.8;

import './IERC165.sol';

abstract contract AERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

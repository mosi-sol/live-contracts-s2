// SPDX-License-Identifier: MIT
pragma solidity 0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBT is ERC721, Ownable{

	event Soulband();

	constructor () ERC721("SBT", "Soulbound Token") {}

	function mint(address to, uint256 tokenId) external onlyOwner {
		_mint(to, tokenId);
	}

	function burn(
        uint256 tokenId
    ) public virtual {
        // _burn(tokenId);
		emit Soulband();
    }

	function transfer(
        address to,
        uint256 tokenId
    ) public virtual {
        // _transfer(to, tokenId);
		emit Soulband();
    }

	function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        // _transfer(from, to, tokenId);
		emit Soulband();
    }

	function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        // safeTransferFrom(from, to, tokenId, "");
		emit Soulband();
    }

	function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public virtual override {
		// _safeTransfer(from, to, tokenId, _data);
		emit Soulband();
    }


}

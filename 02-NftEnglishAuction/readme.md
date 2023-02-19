## Simple Nft Auction
- auction type: [English auction](https://en.wikipedia.org/wiki/English_auction)
- nft type : ERC721 (1 of 1)

#

### how to:
- ***deploy*** by using 
- - nft erc721 address (you are owner)
- - nft id (you are owner)
- - set the price for starting BID price

### test:
- for testing this, you will need erc721 contract like -> [here](https://github.com/mosi-sol/erc721/tree/main/v5)
- remember to call `approve for all` for using in auction
- for better experiance, in `line 74` change value

### features:
- add ERC1155
- change nft address function
- custom ERC20 for pay (buy nft)
- seller can not be bidder (require on bid function)

### important:
***withdraw by using address balance is easiest for hacking, please ensure for using by this term & role***

#

### disclaimer:
***as always*** use this code at your **own risk**


---

<p align="right"> 
<a href="https://github.com/mosi-sol/live-contracts-s2" target="blank">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat" alt="cafe_pafe" /></a>  
</p>

---

### contract info

|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **AuctionNFT** | Implementation | Ownable, ReentrancyGuard |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | startAuction | External ❗️ | 🛑  | onlyOwner |
| └ | bid | External ❗️ |  💵 |NO❗️ |
| └ | end | External ❗️ | 🛑  | onlyOwner |
| └ | _startAuction | Internal 🔒 | 🛑  | |
| └ | _bid | Internal 🔒 | 🛑  | |
| └ | _end | Internal 🔒 | 🛑  | |
| └ | withdraw | External ❗️ | 🛑  | nonReentrant |
| └ | onERC721Received | Public ❗️ | 🛑  |NO❗️ |


 Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |


### signature hash

| Sighash   |   Function Signature | 
| ---- | ---- | 
| 6b64c769  |  startAuction() | 
| 1998aeef  |  bid() | 
| efbe1c1c  |  end() | 
| 1974a003  |  _startAuction() | 
| b45e54fb  |  _bid() | 
| 3c20ee6e  |  _end() | 
| 3ccfd60b  |  withdraw() | 
| 150b7a02  |  onERC721Received(address,address,uint256,bytes) | 

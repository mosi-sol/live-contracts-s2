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

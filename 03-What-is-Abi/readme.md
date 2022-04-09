## What is ABI in Solidity

- run `translate` function
- put an address + an uint

### example result
- recipient: `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`
- amount: `2002`
- output: `0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc400000000000000000000000000000000000000000000000000000000000007d2`

#

1- function signature, bytes4: `0xa9059cbb`

2- recipient address: `0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4`

3- function value: `00000000000000000000000000000000000000000000000000000000000007d2`

### intro
- 0xa9059cbb is encode of `function signature` like: `"functionName(address,uint256)"`
- address (`uit160`)
- 00....007d2 is hex code of '2002'.


function signature: `"translate(address,uint256)"`

#

<p align="right"> 
<a href="https://github.com/mosi-sol/live-contracts-s2" target="blank">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat" alt="cafe_pafe" /></a>  
</p>

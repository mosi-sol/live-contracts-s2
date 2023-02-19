# Crowd Fundraising
- how to start a fund raising campagin
- how to work
- included make by factory pattern

> live stream at 06-22-2022

---

### how to use by factory
- remove or comment line 106 [here](https://github.com/mosi-sol/live-contracts-s2/blob/ef5c79a458d6c452eb535af2dad71a4221d7203b/21-Crowd%20Fund%20Raising%20part%202/CrowdFund-part2.sol#L106) 

### how to deploy & run directly
- use line 106 & compile & deploy [here](https://github.com/mosi-sol/live-contracts-s2/blob/ef5c79a458d6c452eb535af2dad71a4221d7203b/21-Crowd%20Fund%20Raising%20part%202/CrowdFund-part2.sol#L106) 

---

### contract info

|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **CrowdfundingFactory** | Implementation |  |||
| └ | create | Public ❗️ | 🛑  |NO❗️ |
| └ | conterbute | Public ❗️ |  💵 |NO❗️ |
| └ | refund | Public ❗️ | 🛑  |NO❗️ |
| └ | finalize | Public ❗️ | 🛑  |NO❗️ |
| └ | balanceOfCampagin | Public ❗️ |   |NO❗️ |
| └ | balance | Public ❗️ |   |NO❗️ |
| └ | version | Public ❗️ |   |NO❗️ |
||||||
| **Crowdfunding** | Implementation |  |||
| └ | _onlyAdmin | Private 🔐 |   | |
| └ | _onlyFundRaiser | Private 🔐 |   | |
| └ | _isNotEnded | Private 🔐 |   | |
| └ | _areValidToPay | Private 🔐 |   | |
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | <Receive Ether> | External ❗️ |  💵 |NO❗️ |
| └ | <Fallback> | External ❗️ |  💵 |NO❗️ |
| └ | create | Public ❗️ | 🛑  | onlyAdmin |
| └ | conterbute | Public ❗️ |  💵 | isNotEnded |
| └ | refund | Public ❗️ | 🛑  | onlyFundRaiser isNotEnded noReentrant |
| └ | revoke | Public ❗️ | 🛑  | onlyAdmin |
| └ | finalize | Public ❗️ | 🛑  | onlyAdmin |
| └ | _isContract | Internal 🔒 |   | |
| └ | balance | Public ❗️ |   |NO❗️ |
| └ | balanceOf | Public ❗️ |   |NO❗️ |
| └ | balanceOfCampagin | Public ❗️ |   |NO❗️ |
| └ | changeNeedTimer | Public ❗️ |   | onlyAdmin |
| └ | theVersion | Public ❗️ |   |NO❗️ |
| └ | changeVersion | Public ❗️ | 🛑  | onlyAdmin |
||||||
| **IERC20** | Interface |  |||
| └ | totalSupply | External ❗️ |   |NO❗️ |
| └ | balanceOf | External ❗️ |   |NO❗️ |
| └ | allowance | External ❗️ |   |NO❗️ |
| └ | transfer | External ❗️ | 🛑  |NO❗️ |
| └ | approve | External ❗️ | 🛑  |NO❗️ |
| └ | transferFrom | External ❗️ | 🛑  |NO❗️ |
||||||
| **Cipher** | Implementation |  |||
| └ | compare | Internal 🔒 |   | |
| └ | morse_to_char | Internal 🔒 |   | |
| └ | char_to_morse | Internal 🔒 |   | |
| └ | hash | Internal 🔒 |   | |
| └ | dehash | Internal 🔒 |   | |
||||||
| **Test** | Implementation | Cipher |||
| └ | receiveMsg | Public ❗️ |   |NO❗️ |
| └ | sendMsg | Public ❗️ |   |NO❗️ |
||||||
| **TestWord** | Implementation | Cipher |||
| └ | concat | Internal 🔒 |   | |
| └ | morse | Public ❗️ |   |NO❗️ |
||||||
| **Cipher** | Implementation |  |||
| └ | compare | Internal 🔒 |   | |
| └ | char_to_morse_code | Internal 🔒 |   | |
||||||
| **Test** | Implementation | Cipher |||
| └ | morse | Public ❗️ |   |NO❗️ |
||||||
| **Cipher** | Implementation |  |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | _design1 | Internal 🔒 | 🛑  | |
| └ | _design2 | Internal 🔒 | 🛑  | |
| └ | _T | Internal 🔒 |   | |
| └ | concat | Internal 🔒 |   | |
| └ | _generate | Internal 🔒 |   | |
| └ | _pattern_1 | Internal 🔒 | 🛑  | |
| └ | _pattern_2 | Internal 🔒 | 🛑  | |
||||||
| **TestWord** | Implementation | Cipher |||
| └ | unMerge | Public ❗️ |   |NO❗️ |
| └ | generate | Public ❗️ |   |NO❗️ |
| └ | table | Public ❗️ |   |NO❗️ |
| └ | pattern_1 | Public ❗️ | 🛑  |NO❗️ |
| └ | pattern_2 | Public ❗️ | 🛑  |NO❗️ |
||||||
| **Cipher** | Implementation |  |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | _design | Private 🔐 | 🛑  | |
| └ | _T | Internal 🔒 |   | |
| └ | concat | Internal 🔒 |   | |
| └ | _generate | Internal 🔒 |   | |
||||||
| **TestWord** | Implementation | Cipher |||
| └ | generate | Public ❗️ |   |NO❗️ |
| └ | table | Public ❗️ |   |NO❗️ |
||||||
| **Cipher** | Implementation |  |||
| └ | compare | Internal 🔒 |   | |
| └ | _T | Internal 🔒 |   | |
| └ | T | Public ❗️ |   |NO❗️ |
| └ | isValid | Public ❗️ |   |NO❗️ |
||||||
| **NoFeeSwap2Pairs** | Implementation |  |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | _lock | Private 🔐 | 🛑  | |
| └ | _release | Private 🔐 | 🛑  | |
| └ | _hold | Private 🔐 | 🛑  | |
| └ | createValuetion | External ❗️ | 🛑  |NO❗️ |
| └ | clearValuetion | External ❗️ | 🛑  |NO❗️ |
| └ | swap | External ❗️ | 🛑  | isValidToken |
| └ | _min | Private 🔐 |   | |
| └ | _sqrt | Private 🔐 |   | |
| └ | sqrt_ | Private 🔐 |   | |
| └ | _this | Internal 🔒 |   | |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _msgValue | Internal 🔒 |   | |
||||||
| **IERC20** | Interface |  |||
| └ | totalSupply | External ❗️ |   |NO❗️ |
| └ | balanceOf | External ❗️ |   |NO❗️ |
| └ | transfer | External ❗️ | 🛑  |NO❗️ |
| └ | allowance | External ❗️ |   |NO❗️ |
| └ | approve | External ❗️ | 🛑  |NO❗️ |
| └ | transferFrom | External ❗️ | 🛑  |NO❗️ |


 Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |

### signature hash

| Sighash   |   Function Signature | 
| ---- | ---- | 
| fd768f55  |  create(address,uint256,uint256,bool) | 
| 9495cd98  |  conterbute(uint256) | 
| 278ecde1  |  refund(uint256) | 
| 05261aea  |  finalize(uint256) | 
| 1bb58744  |  balanceOfCampagin(uint256) | 
| b69ef8a8  |  balance() | 
| 54fd4d50  |  version() | 
| ab2b1ca4  |  _onlyAdmin() | 
| f939c53f  |  _onlyFundRaiser() | 
| ee6c924b  |  _isNotEnded(uint256) | 
| 01af6d7e  |  _areValidToPay(uint256) | 
| 20c5429b  |  revoke(uint256) | 
| 7d48441f  |  _isContract(address) | 
| 00fdd58e  |  balanceOf(address,uint256) | 
| 5edd94a0  |  changeNeedTimer() | 
| 1d01762c  |  theVersion() | 
| 107752fe  |  changeVersion(uint256) | 
| 18160ddd  |  totalSupply() | 
| 70a08231  |  balanceOf(address) | 
| dd62ed3e  |  allowance(address,address) | 
| a9059cbb  |  transfer(address,uint256) | 
| 095ea7b3  |  approve(address,uint256) | 
| 23b872dd  |  transferFrom(address,address,uint256) | 

# Multisig Wallet

- in this version i try to : 
- - working by mapping like a database.
- - save gas 

### there is a bug: 
- in the `constructor` would to check : **owners >= signers(validators)**
- for fix in backend just check
- or in frontend check those values

> live stream at 06-20-2022

---

in test on remix, i use this accounts as owners
```
["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
"0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
"0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
```
and use this account is/as recipient 
`0xdD870fA1b7C4700F2BD7f44238821C26f7392148`

---

### contract info

|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **MultiSigWallet** | Implementation |  |||
| └ | _onlyOwner | Private 🔐 |   | |
| └ | _onlySigner | Private 🔐 |   | |
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | <Fallback> | External ❗️ |  💵 |NO❗️ |
| └ | <Receive Ether> | External ❗️ |  💵 |NO❗️ |
| └ | deposit | Public ❗️ |  💵 |NO❗️ |
| └ | withdraw | Private 🔐 | 🛑  | onlySigner |
| └ | submit | Public ❗️ | 🛑  | onlySigner |
| └ | confirm | Public ❗️ | 🛑  | onlySigner |
| └ | revoke | Public ❗️ | 🛑  | onlySigner |
| └ | balance | Public ❗️ |   |NO❗️ |
| └ | investor | Public ❗️ |   |NO❗️ |
| └ | investor | Public ❗️ |   |NO❗️ |
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
| **Recurit** | Implementation | Ownable |||
| └ | finish | Public ❗️ | 🛑  |NO❗️ |
| └ | depositsOf | Public ❗️ |   |NO❗️ |
| └ | deposit | External ❗️ |  💵 | onlyOwner |
| └ | withdraw | External ❗️ | 🛑  | onlyOwner |
| └ | _deposit | Internal 🔒 | 🛑  | onlyOwner |
| └ | _withdraw | Internal 🔒 | 🛑  | onlyOwner |
||||||
| **Wrapped** | Implementation | ERC20 |||
| └ | <Constructor> | Public ❗️ | 🛑  | ERC20 |
| └ | isBalanced | Internal 🔒 |   | |
| └ | returnDecimals | Public ❗️ |   |NO❗️ |
| └ | returnBalances | Public ❗️ |   |NO❗️ |
| └ | returnDeposited | Public ❗️ |   |NO❗️ |
| └ | returnDeposited | Public ❗️ |   |NO❗️ |
| └ | deposit | External ❗️ | 🛑  |NO❗️ |
| └ | withdraw | External ❗️ | 🛑  |NO❗️ |
| └ | withdraw | External ❗️ | 🛑  |NO❗️ |
| └ | refund | External ❗️ | 🛑  |NO❗️ |
| └ | _terminate | Internal 🔒 | 🛑  | |
| └ | mint | Internal 🔒 | 🛑  | |
| └ | burn | Internal 🔒 | 🛑  | |
| └ | _decimals | Private 🔐 |   | |


 Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |

### signature hash

| Sighash   |   Function Signature | 
| ---- | ---- | 
| 71dfb281  |  _onlyOwner() | 
| 4cc81585  |  _onlySigner() | 
| d0e30db0  |  deposit() | 
| e63697c8  |  withdraw(uint256,address,uint256) | 
| 203dd666  |  submit(address,uint256) | 
| ba0179b5  |  confirm(uint256) | 
| 20c5429b  |  revoke(uint256) | 
| b69ef8a8  |  balance() | 
| 1e0018d6  |  investor() | 
| 1b1cd4ff  |  investor(address) | 

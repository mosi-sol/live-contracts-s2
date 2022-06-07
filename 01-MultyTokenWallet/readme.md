### functions native
- receive 'as a deposit'
- withdraw
- balance

### functions ERC20 token
- deposit
- withdraw
- balance
- change custom token

### info
- `increaseAllowance(address(this), _amount);` <- this is for allowance of custom token, do handly by sender
- need more requirment for finish this code, but logic is finished.

### security info
not use `function changeToken`, if you not withdraw

#

### important feature
use safe transfering function like the code in below { [source here](https://github.com/mosi-sol/live-contracts/tree/main/episode-19) }
```
function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount) private returns (bool) {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
        return sent;
    }
```

---

<p align="right"> 
  <a href="https://github.com/mosi-sol" target="blank">
  <img src="https://img.shields.io/badge/Multy%20Token-Wallet-blue?style=flat" alt="cafe_pafe" /></a>  
</p>

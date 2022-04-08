## simple logic of staking

watch the logic of stake (not 'reward , timelock , pool' was added).

in this example you can use `IERC20` object use is/as in `staking(address token,` . like `staking(IERC20 token,`

---
```solidity
// deploy this token for test
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract TestToken is ERC20 {
    constructor(string memory _name, string memory _symbol) 
    ERC20(_name, _symbol) {
        _mint(msg.sender, 1000000000000000000000);
    }
}
```
dont forget to approve `stake contract` for spending/allowing test token.

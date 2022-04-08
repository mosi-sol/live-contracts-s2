## simple logic of staking

watch the logic of stake (not 'reward , timelock , pool' was added).

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

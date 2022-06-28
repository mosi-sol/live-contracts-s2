# Chatroom
- @title: simple social media, look like a chat room.
- @dev: stringToBytes() AND bytesToString() use for test. in frontend you can use ethersjs for this goal.
- @info: in frontend change bytes to string OR string to bytes has no cost for transaction.

---
> 06-28-2022 live stream.

## BSC testnet
- 0x8b613e017Ae1658837B9f65c2CA8FD1dAa54AE3f
- https://testnet.bscscan.com/address/0x8b613e017ae1658837b9f65c2ca8fd1daa54ae3f

- if you check the events, tokenId 1 : encrypted -> Hello everyone, welcome
- and answered is: encrypted -> 06-29-2022 (wednesday)

##

### stringToBytes() -> encoder
- mosi said hello, yelling welcome! 1234567890

### bytesToString() -> decoder
- 0x000000000000000000000000000000000000000000000000000000000000002
    000000000000000000000000000000000000000000000000000000000000000
    2c6d6f736920736169642068656c6c6f2c2079656c6c696e672077656c636f6d6521203132333435363738393
    00000000000000000000000000000000000000000
    
- - `2c` is the length
- - `6d6f736920736169642068656c6c6f2c2079656c6c696e672077656c636f6d6521203132333435363738393` is message

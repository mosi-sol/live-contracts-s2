# Chatroom
- @title: simple social media, look like a chat room.
- @dev: stringToBytes() AND bytesToString() use for test. in frontend you can use ethersjs for this goal.
- @info: in frontend change bytes to string OR string to bytes has no cost for transaction.

---
> 06-28-2022 live stream.

### stringToBytes() -> encoder
- mosi said hello, yelling welcome! 1234567890

### bytesToString() -> decoder
- 0x000000000000000000000000000000000000000000000000000000000000002
    000000000000000000000000000000000000000000000000000000000000000
    2c6d6f736920736169642068656c6c6f2c2079656c6c696e672077656c636f6d6521203132333435363738393
    00000000000000000000000000000000000000000
    
- - `2c` is the length
- - `6d6f736920736169642068656c6c6f2c2079656c6c696e672077656c636f6d6521203132333435363738393` is message

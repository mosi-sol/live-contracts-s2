// SPDX-License-Identifier: MIT
pragma solidity 0.8;

contract MultiSigWallet {
    // var --------------------------------
    uint private transactionId;
    uint private _howMuchValidator;
    address private _owner;
    address[] public owners;
    mapping(address => bool) private _signers; // isOwner
    mapping(address => uint) private _depositor;
    mapping(uint => mapping(address => bool)) private _validats;
    mapping(uint => address) private _requestAddress; // txId -> adress withdraw 
    mapping(uint => mapping(address => uint)) private _request; // txId -> adress withdraw -> amount
    mapping(uint => uint) private _votes;

    // events --------------------------------
    // deposit eth
    event Deposit(address sender, uint amount, uint time);
    // submit withdraw
    event Submit(address sender, address recipient, uint amount);
    // confirm withdraw
    event Confirm(address voted, uint votes, uint txId);
    // cancel confermation
    event Revoke(address voted, uint votes, uint txId);
    // execute transaction (withdraw)
    event Execute(address recipient, uint txId, uint amount);

    // modifiers --------------------------------
    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    modifier onlySigner() {
       _onlySigner();
        _;
    }

    // validators --------------------------------
    function _onlyOwner() private view {
        require(msg.sender == _owner, "only owner is valid");
    }
    
    function _onlySigner() private view {
         require(_signers[msg.sender],"just valid user");
    }

    // init --------------------------------
    constructor(address[] memory _new, uint howMuchValidator) {
        _owner = msg.sender;
        transactionId = 0;
        _howMuchValidator = howMuchValidator;
        uint j = _new.length;
        for (uint i = 0; i < j; i++) {
            address owner = _new[i];

            require(owner != address(0), "invalid owner");
            require(!_signers[owner], "owner not unique");

            _signers[owner] = true;
            owners.push(owner);
        }
    }

    // calculations --------------------------------
    fallback() external payable {
        deposit();
    }
    
    receive() external payable {
        deposit();
    }

    function deposit() payable public returns (uint amount) {
        require(msg.value > 0, "why spend gas!?");
        amount = msg.value;
        _depositor[msg.sender] += amount;
        emit Deposit(msg.sender, amount, block.timestamp);
    }

    function withdraw(uint txId, address recipient, uint amount) private onlySigner returns (bool) {
        require(address(this).balance >= amount, "fund have not enought");
        // confirm check (_howMuchValidator)
        require(transactionId > 0 && txId > 0, "not existed transaction");
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "transaction failed");
        return success;
    }

    function submit(address recipient, uint amount) public onlySigner returns (uint) {
        require(recipient != address(0), "submit failed, dont go to black hole!");
        transactionId += 1;
        _request[transactionId][recipient] = amount;
        _requestAddress[transactionId] = recipient;
        emit Submit(msg.sender, recipient, amount);
        return transactionId;
    }

    function confirm(uint txId) public onlySigner returns (bool) {
        require(transactionId > 0 && txId > 0, "not existed transaction");
        require(!_validats[transactionId][msg.sender], "you are confirmed");
        _validats[transactionId][msg.sender] = true;
        _votes[txId] += 1;
        emit Confirm(msg.sender, _votes[txId], txId);
        if(_votes[txId] >= _howMuchValidator){
            withdraw(txId, _requestAddress[txId], _request[txId][_requestAddress[txId]]);
            emit Execute(_requestAddress[txId], txId, _request[txId][_requestAddress[txId]]);
            return true;
        }else{
            return false;
        }
    }

    function revoke(uint txId) public onlySigner returns (bool) {
        require(transactionId > 0 && txId > 0, "not existed transaction");
        require(_validats[transactionId][msg.sender], "you are not allowed");
        _validats[transactionId][msg.sender] = false;
        unchecked {_votes[txId] -= 1;}
        emit Revoke(msg.sender, _votes[txId], txId);
        return true;
    }

    function balance() public view returns (uint amount) {
        amount = address(this).balance;
    }

    function investor() public view returns (uint amount) {
        amount = _depositor[msg.sender];
    }

    function investor(address _investor) public view returns (uint amount) {
        amount = _depositor[_investor];
    }
}


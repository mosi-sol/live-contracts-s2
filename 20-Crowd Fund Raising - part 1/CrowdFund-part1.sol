// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8;

contract CrowdfundingFactory {
    Crowdfunding crowdfunding = new Crowdfunding();
    // crowdfunding.create();
}

contract Crowdfunding {
    // variables -----------------------------------------
    address payable private _admin;
    struct CROWD {
        uint id;
        uint raiseAmount;
        uint start;
        uint end;
        uint shareCount;
        uint conterbuter;
        address benefit;
        bytes16 data;
        bool finished;
    } 
    mapping(address => mapping(uint => uint)) private _balanceOf;
    mapping(uint => uint) private _balanceOfCampagin;
    mapping(address => bool) private _fundRaiser;
    mapping(uint => CROWD) public campagin;
    uint campaginId;

    bytes16[] public isValidData;

    // events -----------------------------------------
    event Received(address, uint);

    // modifiers -----------------------------------------
    modifier onlyAdmin() {
        _onlyAdmin();
        _;
    }
    
    modifier onlyFundRaiser() {
        _onlyFundRaiser();
        _;
    }
    
    modifier isNotEnded(uint id) {
        _isNotEnded(id);
        _;
    }
    
    function _onlyAdmin() private view {
        require(msg.sender == _admin, "you are not allowed");
    }
    
    function _onlyFundRaiser() private view {
        require(_fundRaiser[msg.sender], "you are not allowed");
    }
    
    function _isNotEnded(uint id) private view {
        require(!campagin[id].finished, "campagin finished");
    }

    // init -----------------------------------------
    constructor() {
        _admin = payable(msg.sender);
        campaginId = 0;
        isValidData.push(0); // we want start from 1, like campaginId
    }

    receive () payable external {emit Received(msg.sender, msg.value);}
    fallback () payable external {emit Received(msg.sender, msg.value);}

    // calculation -----------------------------------------
    function create(address benefit, uint amount, uint end) public onlyAdmin returns (bytes16) {
        // validating the benefit address not a smartContract
        require(!_isContract(benefit), "NOT VALID: benefitial address is contract address");
        campaginId += 1;
        uint start = block.timestamp;
        bytes16 DATA = bytes16(
            keccak256(abi.encodePacked(msg.sender, benefit, amount, campaginId, start))
        ); // type(Crowdfunding).creationCode
        isValidData.push(DATA);
        _balanceOfCampagin[campaginId] = 0;
        campagin[campaginId] = CROWD(
            campaginId,
            amount,
            start,
            start + end,
            0,
            0,
            benefit,
            DATA,
            false
        );
        return DATA;
    }

    function conterbute(uint _campaginId) public payable isNotEnded(_campaginId) returns (bool) {
        require(!_isContract(msg.sender), "NOT VALID: conterbuter address is contract address");
        require(_campaginId > 0 , "un-deployed campagin");
        require(campagin[_campaginId].raiseAmount > _balanceOfCampagin[_campaginId], "rise up ended");
        campagin[_campaginId].conterbuter += 1;
        campagin[_campaginId].shareCount += msg.value;
        _balanceOf[msg.sender][_campaginId] += msg.value;
        _balanceOfCampagin[_campaginId] += msg.value;
        _fundRaiser[msg.sender] = true;
        if(balanceOfCampagin(_campaginId) >= campagin[_campaginId].raiseAmount){
            campagin[_campaginId].finished = true;
        }
        return true;
    }

    function refund() public onlyFundRaiser {
        
    }

    function revoke() public onlyFundRaiser {
        
    }

    function finalize(uint _campaginId) public payable onlyAdmin returns (bool, uint) {
        require(balance() >= balanceOfCampagin(_campaginId), "somethings wrong, meybe campagin not finished yet");
        require(campagin[_campaginId].finished, "campagin not finished yet");
        campagin[_campaginId].finished = true;
        uint _amount = _balanceOfCampagin[_campaginId];
        _balanceOfCampagin[_campaginId] = 0;
        (bool success, ) = payable(campagin[_campaginId].benefit).call{value: balanceOfCampagin(_campaginId)}("");
        return (success, _amount);
    }

    // helper -----------------------------------------
    function _isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
        // check value for reciever is account or contact address
    }

    function balance() public view returns (uint) {
        return address(this).balance;
    }

    function balanceOf(address addr, uint id) public view returns (uint) {
        return _balanceOf[addr][id];
    }

    function balanceOfCampagin(uint id) public view returns (uint) {
        return _balanceOfCampagin[id];
    }
}

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8;

contract CrowdfundingFactory {
    Crowdfunding crowdfunding = new Crowdfunding(); // new Crowdfunding(address)
    
    function create(address benefit, uint amount, uint end, bool timerNeed) public {
        crowdfunding.create(benefit, amount, end, timerNeed);
    }

    // to run conterbute = remove or commenting first valdator on -> _areValidToPay function in -> Crowdfunding contract (line 106)
    function conterbute(uint _campaginId) public payable {
        crowdfunding.conterbute(_campaginId);
    }

    function refund(uint _campaginId) public {
        crowdfunding.refund(_campaginId);
    }

    function finalize(uint _campaginId) public {
        crowdfunding.finalize(_campaginId);
    }

    function balanceOfCampagin(uint _campaginId) public view returns (uint) {
        return crowdfunding.balanceOfCampagin(_campaginId);
    }

    function balance() public view returns (uint) {
        return crowdfunding.balance();
    }

    function version() public view returns (uint) {
        return crowdfunding.theVersion();
    }
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
        bytes16 data; // usecase: check for more security OR easy search
        bool finished;
    } 
    mapping(address => mapping(uint => uint)) private _balanceOf;
    mapping(uint => uint) private _balanceOfCampagin;
    mapping(address => bool) private _fundRaiser;
    mapping(uint => CROWD) public campagin;
    uint campaginId;
    uint version = 1;
    bool private needTimer = false; // false for unlimited time
    bool internal locked;

    bytes16[] public isValidData;

    // events -----------------------------------------
    event Received(address, uint);
    event Create(uint indexed _campaginId, address indexed recipint, uint startTime, uint amount, bytes16 unique);
    event Conterbute(uint indexed _campaginId, address indexed sender, uint time, uint amount);
    event Refund(uint indexed _campaginId, address indexed sender, uint time, uint amount);
    event Finalize(uint indexed _campaginId, address indexed recipient, uint finishTime, uint amount);

    // modifiers -----------------------------------------
    modifier onlyAdmin() {
        _onlyAdmin();
        _;
    }
    
    modifier onlyFundRaiser() { // add campaginId as a value for seprat all fundraisers
        _onlyFundRaiser();
        _;
    }
    
    modifier isNotEnded(uint id) {
        _isNotEnded(id);
        _;
    }

    modifier noReentrant() {
		require(!locked, "no re entrancy");
		locked = true;
		_;
		locked = false;
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

    function _areValidToPay(uint _campaginId) private view returns (bool) { // conterbute function validators
        // if run fron factory, remove next line
        require(!_isContract(msg.sender), "NOT VALID: conterbuter address is contract address");
        require(_campaginId > 0 , "un-deployed campagin");
        require(campagin[_campaginId].raiseAmount > _balanceOfCampagin[_campaginId], "rise up ended");
        return true;
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
    function create(address benefit, uint amount, uint end, bool timerNeed) public onlyAdmin returns (bytes16) {
        // validating the benefit address not a smartContract
        require(!_isContract(benefit), "NOT VALID: benefitial address is contract address");
        needTimer = timerNeed;
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
        emit Create(campaginId, benefit, start, amount, DATA);
        return DATA;
    }

    function conterbute(uint _campaginId) public payable isNotEnded(_campaginId) returns (bool) {
        require(_areValidToPay(_campaginId));
        if (!needTimer) {
            campagin[_campaginId].conterbuter += 1;
            campagin[_campaginId].shareCount += msg.value;
            _balanceOf[msg.sender][_campaginId] += msg.value;
            _balanceOfCampagin[_campaginId] += msg.value;
            _fundRaiser[msg.sender] = true;
            if(balanceOfCampagin(_campaginId) >= campagin[_campaginId].raiseAmount){
                campagin[_campaginId].finished = true;
            }
            emit Conterbute(_campaginId, msg.sender, block.timestamp, msg.value);
            return true;
        }
        else {
            require(campagin[_campaginId].end < block.timestamp, "time out!");
            campagin[_campaginId].conterbuter += 1;
            campagin[_campaginId].shareCount += msg.value;
            _balanceOf[msg.sender][_campaginId] += msg.value;
            _balanceOfCampagin[_campaginId] += msg.value;
            _fundRaiser[msg.sender] = true;
            if(balanceOfCampagin(_campaginId) >= campagin[_campaginId].raiseAmount){
                campagin[_campaginId].finished = true;
            }            
            emit Conterbute(_campaginId, msg.sender, block.timestamp, msg.value);
            return true;
        }
    }

    function refund(uint _campaginId) public onlyFundRaiser isNotEnded(_campaginId) noReentrant returns (bool, uint) {
        if(needTimer) {
            require(campagin[_campaginId].end < block.timestamp, "campagin finished");
        }
        require(_balanceOf[msg.sender][_campaginId] > 0, "you are not raise in this campagin");
        uint val = _balanceOf[msg.sender][_campaginId];
        _balanceOf[msg.sender][_campaginId] = 0;
        // payable(msg.sender).transfer(val); // old way & not secure
        (bool success, ) = msg.sender.call{value: val}("");
        if(!success){_balanceOf[msg.sender][_campaginId]=val;} // not secure method at all, but  only way in his pattern
        if(success){
            campagin[_campaginId].conterbuter -= 1;
            campagin[_campaginId].shareCount -= val;
            _balanceOfCampagin[_campaginId] -= val;
            _balanceOf[msg.sender][_campaginId] -= val;
            _fundRaiser[msg.sender] = false;
        }
        require(success);
        emit Refund(_campaginId, msg.sender, block.timestamp, val);
        return(success, val);
    }

    function revoke(uint _campaginId) public onlyAdmin {
        // not suggested method, cuz refund is avalible
    }

    function finalize(uint _campaginId) public onlyAdmin returns (bool, uint) {
        require(balance() >= balanceOfCampagin(_campaginId), "somethings wrong, meybe campagin not finished yet");
        require(campagin[_campaginId].finished, "campagin not finished yet");
        if(needTimer) {
            require(campagin[_campaginId].end > block.timestamp, "wait to finish the time!");
        }
        campagin[_campaginId].finished = true;
        uint _amount = _balanceOfCampagin[_campaginId];
        _balanceOfCampagin[_campaginId] = 0;
        (bool success, ) = payable(campagin[_campaginId].benefit).call{value: _amount}("");
        if(!success){_balanceOfCampagin[_campaginId] = _amount;} // not secure method at all, but  only way in his pattern
        require(success, "transaction failed");
        emit Finalize(_campaginId, campagin[_campaginId].benefit, block.timestamp, _amount);
        return (success, _amount);
    }

    // helper -----------------------------------------
    function _isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
        // check value for reciever is account or contract address
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

    function changeNeedTimer() public view onlyAdmin {
        needTimer == !needTimer;
    }

    function theVersion() public view returns (uint) {
        return version;
    }

    function changeVersion(uint ver) public onlyAdmin returns (uint) {
        version = ver;
        return version;
    }
}

/* ----------------------------------------------------------- */
/*
some times crowdfundig (fundraising) need to custom tokens.
then we use IERC20 for connect contract to the custom tokens.
using like this -> IERC20 PUBLIC token; token = IEC20(address);
*/

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

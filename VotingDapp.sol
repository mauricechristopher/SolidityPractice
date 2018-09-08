pragma solidity ^0.4.24;

contract ballot {
    uint partyA;
    uint partyBoring;
    uint time;
    address owner;
    mapping (address => bool) voters;
    
    constructor (address owner) public {
        partyA = 0;
        partyBoring = 0;
        time = now;
        owner = msg.sender;
    }
    
    modifier hasNotVoted {
        require(voters[msg.sender] == false);
        _;
        voters[msg.sender] = true;
    }
    
    modifier timesNotUp {
        require(now < time + 20);
        _;
    }
    modifier timesUp {
        require(now > time + 20);
        _;
    }
    
    function votePartyA() hasNotVoted timesNotUp public {
        owner.delegatecall(bytes4(keccak256("votePartyA()")));
    }
    
    function votePartyBoring() hasNotVoted timesNotUp public {
        owner.delegatecall(bytes4(keccak256("votePartyBoring()")));
    }
    
    function winner() timesUp public view returns(string) {
        owner.delegatecall(bytes4(keccak256("winner()")));
    }
}

contract proxy {
    uint partyA;
    uint partyBoring;
    uint time;
    mapping (address => bool) voters;
    
    constructor () public {
        partyA = 0;
        partyBoring = 0;
        time = now;
    }
    
    function votePartyA() public {
        partyA++;
    }
    
    function votePartyBoring() public {
        partyBoring++;
    }
    
    function winner() public view returns(string) {
        if (partyA > partyBoring)
            return("PartyA is your ruler");             
        else if (partyA < partyBoring)
            return("PartyB is your ruler");
        else
            return("there was a tie");
    }
}
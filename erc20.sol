pragma solidity ^0.4.24;

contract moCoin {
    
    address public owner;
    uint public total;
    string public name;
    mapping (address => uint) public token;
    
    constructor (uint _total, string _name) public 
    {
        owner = msg.sender;
        _total = total;
        _name = name;
        token[owner] = total;
    }
    
    modifier isOwner {
        require(msg.sender == owner);
        _;
    }
    
    function purchaseICO() external payable
    {
        require(msg.value > 0);
        require(token[owner] >= (msg.value / 1 ether) * 1000);
        token[owner] -= (msg.value / 1 ether) * 1000;
        token[msg.sender] += (msg.value / 1 ether) * 1000;
    }
    
    function transferTokens (address _newAddress, uint _value) external payable {
        require(token[msg.sender] >= _value);
        token[msg.sender] -= _value;
        token[_newAddress] += _value;
    }
    
    function balanceOf(address _owner) public view returns (uint balance) 
    {
        return token[_owner];
    }
    
    function withdrawEth() public payable isOwner
    {
        msg.sender.transfer(address(this).balance);
    }

}
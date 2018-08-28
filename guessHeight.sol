pragma solidity ^0.4.24;

contract guessHeight {

    uint8 private height;
    address public owner;
    bool finished;
    
    event Guess(bool correct, string direction);
    
    modifier gameOver ()
    {
        require(!finished);
        _;
    }
    
    modifier onlyOwner()
    {
        require(owner == msg.sender);
        _;
    }
    
    modifier gameNotOver ()
    {
        require(finished);
        _;
    }
    
    constructor (uint8 _height) public payable
    {
        height = _height;
        //require the contract to be sent 5 ether to create it
        require(msg.value == 1 ether / 2);
        owner = msg.sender;
    }
    
    function makeGuess(uint8 guess) public payable
    {
        require(msg.value == 1 ether / 10);
        if (guess == height)
        {
            msg.sender.transfer(1 ether / 2);
            emit Guess(true, "Correct");
            finished = true;
        }
        else if (guess > height)
        {
            emit Guess(false, "The answer is lower than your guess");
        }
        
        else
        {
            emit Guess(false, "The answer is higher than your guess");
        }
    }
    
    function withdrawalEth() public payable onlyOwner gameOver
    {
        
        msg.sender.transfer(address(this).balance);
    }

}
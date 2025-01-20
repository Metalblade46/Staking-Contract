// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
interface IToken{
    function mint(address _acount, uint256 _amount) external;
}
contract Stake is Ownable{
    address token_address;
    mapping(address=>uint) stakes;
    mapping(address=>uint) rewards;
    mapping(address=>uint) updated;
    constructor() Ownable(msg.sender){

    }
    function setToken(address _token_address) external onlyOwner(){
        token_address = _token_address;
    }
    function stake(uint256 _amount) public payable{
        require(_amount>0,'Amount needs to be greater than 0');
        require(msg.value == _amount, 'Please send appropriate amount');
        uint lastTimestamp = updated[msg.sender];
        rewards[msg.sender]+=((block.timestamp- lastTimestamp)/24 days)*stakes[msg.sender]*20;
        updated[msg.sender] = block.timestamp;
        stakes[msg.sender]+=_amount;
    }
    function unstake(uint256 _amount) public{
        require(stakes[msg.sender]>=_amount,"Not enough stakes");
        payable(msg.sender).transfer(_amount);
        stakes[msg.sender]-=_amount;
    }
    function claimRewards() public{
        IToken(token_address).mint(msg.sender, stakes[msg.sender]);
    }
}
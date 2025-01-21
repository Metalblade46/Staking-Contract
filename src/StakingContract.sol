// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IToken {
    function mint(address _acount, uint256 _amount) external;
}

contract Stake is Ownable {
    address token_address;
    mapping(address => uint256) stakes;
    mapping(address => uint256) rewards;
    mapping(address => uint256) updated;

    constructor() Ownable(msg.sender) {}

    function setToken(address _token_address) external onlyOwner {
        token_address = _token_address;
    }

    function stake(uint256 _amount) public payable {
        require(_amount > 0, "Amount needs to be greater than 0");
        require(msg.value == _amount, "Please send appropriate amount");
        uint256 lastTimestamp = updated[msg.sender];
        if(lastTimestamp ==0) lastTimestamp = block.timestamp;
        rewards[msg.sender] +=
            ((block.timestamp - lastTimestamp) / 1 minutes) *
            stakes[msg.sender] *
            20;
        updated[msg.sender] = block.timestamp;
        stakes[msg.sender] += _amount;
    }

    function unstake(uint256 _amount) public {
        require(stakes[msg.sender] >= _amount, "Not enough stakes");
        uint256 lastTimestamp = updated[msg.sender];
        rewards[msg.sender] +=
            ((block.timestamp - lastTimestamp) / 1 minutes) *
            stakes[msg.sender] *
            20;
        payable(msg.sender).transfer(_amount);
        stakes[msg.sender] -= _amount;
        updated[msg.sender] =block.timestamp;
    }
    function getRewards() public view returns (uint256){
        require(stakes[msg.sender] >= 0, "No stakes");
        uint256 lastTimestamp = updated[msg.sender];
        return rewards[msg.sender] + ((block.timestamp - lastTimestamp) / 1 minutes) * stakes[msg.sender] *20;
    }
    function claimRewards() public {
        uint256 lastTimestamp = updated[msg.sender];
        rewards[msg.sender] +=
            ((block.timestamp - lastTimestamp) / 1 minutes) *
            stakes[msg.sender] *
            20;
        require(rewards[msg.sender]>0);
        IToken(token_address).mint(msg.sender, rewards[msg.sender]);
        rewards[msg.sender] = 0;
        updated[msg.sender] =block.timestamp;
    }
}

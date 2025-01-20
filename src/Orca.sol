// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Orca is ERC20, Ownable{
    address staking_contract = address(0);
    constructor() ERC20("OrcaToken", "ORCA") Ownable(msg.sender){
    }
    modifier onlyContract {
        require(msg.sender == staking_contract);
        _;
    }
    function mint(address _acount, uint256 _amount) onlyContract external{
        _mint(_acount, _amount);
    }
    function changeStakingContract(address _contract) public onlyOwner(){
        staking_contract = _contract;
    }
    
}
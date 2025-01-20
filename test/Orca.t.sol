// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Orca.sol";

contract TestOrca is Test {
    Orca c;

    function setUp() public {
        c = new Orca();
    }
    function testInitialSupply() public {
        assertEq(c.totalSupply(), 0);
    }

    function testFailMint() public{
        vm.prank(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca);
        c.mint(address(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca), 1000);
        assertEq(c.balanceOf(address(this)), 1000);
    }
    function testMint() public{
        c.changeStakingContract(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca);
        vm.prank(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca);
        c.mint(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca, 10);
        assertEq(c.balanceOf(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca),10);
    }
}
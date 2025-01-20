// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakingContract.sol";

contract TestOrca is Test {
    Stake c;

    function setUp() public {
        c = new Stake();
    }
    function testStake() public {
        vm.deal(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca, 2 ether);
        vm.prank(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca);
        c.stake{value: 1 ether}(1000000000000000000);
        assertEq(address(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca).balance, 1 ether);
        assertEq(address(c).balance, 1 ether);
    }
        function testUnStake() public {
        vm.deal(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca, 2 ether);
        vm.startPrank(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca);
        c.stake{value: 2 ether}(2000000000000000000);
        assertEq(address(c).balance, 2 ether);
        c.unstake(1000000000000000000);
        assertEq(address(c).balance, 1 ether);
        assertEq(address(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca).balance, 1 ether);
    }
        function testFailStake() public {
        vm.deal(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca, 2 ether);
        vm.prank(0x9Ad1cB2b44cA62B0B8e0eB8D157a5e07181E46ca);
        c.stake{value: 0}(0);
    }


}
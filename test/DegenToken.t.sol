// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test, console2 } from "forge-std/Test.sol";
import { DegenToken } from "../src/DegenToken.sol";

contract DegenTokenTest is Test {
    DegenToken public degentoken;

address accountHolder = makeAddr("accountHolder");
address beneficiary = makeAddr("beneficiary");

    function setUp() public {
        vm.startPrank(accountHolder);
        degentoken = new DegenToken();
        vm.stopPrank();
    }

    function testMint() public {
        vm.prank(accountHolder);
        degentoken.mintTokens(beneficiary, 500); 
        assertEq(degentoken.balanceOf(beneficiary), 500);
    }

    function testCreateRedeem() public {
        vm.prank(accountHolder);
        degentoken.createRedemptionItem("testItem", 200); 
        assertEq(degentoken.viewRedemption(1).owner, accountHolder);
        assertEq(degentoken.viewRedemption(1).name, "testItem");
        assertEq(degentoken.viewRedemption(1).amount, 200);
    }

    function testTransferToken() public {
        vm.startPrank(accountHolder);
        degentoken.mintTokens(accountHolder, 1000); 
        degentoken.transferTokens(beneficiary, 100);  
        assertEq(degentoken.balanceOf(beneficiary), 100);
        assertEq(degentoken.balanceOf(accountHolder), 900);
    }

    function testInsufficientBalance() public {
       vm.startPrank(accountHolder);
       degentoken.mintTokens(accountHolder, 500);
       vm.expectRevert("Insufficient balance");
       degentoken.transferTokens(beneficiary, 600);
    
    }

    function testBurn() public {
        vm.startPrank(accountHolder);
        degentoken.mintTokens(accountHolder, 300); 
        degentoken.burnTokens(50);
        assertEq(degentoken.balanceOf(accountHolder), 250);
    }

       function testRedeemToken() public {
        vm.startPrank(accountHolder);
        degentoken.mintTokens(accountHolder, 1000);  
        degentoken.createRedemptionItem("testItem", 500); 
        degentoken.redeemToken(1);
        vm.stopPrank();

        assertEq(degentoken.balanceOf(accountHolder), 1000);
    }

    function testBurnFailIfBalanceIsInsufficient() public {
        vm.startPrank(accountHolder);
        degentoken.mintTokens(accountHolder, 500); 
        vm.expectRevert("You don't have enough");
        degentoken.burnTokens(750); 
    }

 
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Utilities} from "./utils/Utilities.sol";
import {FoundryToken} from "../src/FoundryToken.sol";

contract FoundryTokenTest is Test {
    Utilities internal utils;
    FoundryToken internal token;

    address payable internal alice; //Create address of alice user
    address payable internal bob; //Create address of bob user

    function setUp() public {
        utils = new Utilities();
        token = new FoundryToken(1000); //Create token with 1000 minted units

        // Create a user
        address payable[] memory users = utils.createUsers(2);

        // Assign the user 0 as Alice
        alice = users[0];
        vm.label(alice, "Alice");

        // Assign the user 0 as Alice
        bob = users[1];
        vm.label(bob, "Bob");
    }

    //Check the name of the token
    function testName() public {
        assertEq(token.name(), "FoundryToken");
    }

    //Check the symbol of the token
    function testTokenSymbol() public {
        assertEq(token.symbol(), "FTK");
    }

    //Check the supply of the minted tokens
    function testSupply() public {
        assertEq(token.totalSupply(), 1000);
    }

    //Check that only the owner can mint more tokens
    function testOnlyOwnerCanMint() public {
        // The owner can mint more tokens
        token.mintFor(address(this), 1000);
        assertEq(token.totalSupply(), 2000);

        // Alice can't mint more tokens
        vm.startPrank(alice);
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        token.mintFor(alice, 1000);
    }

    //Check transfer of tokens. Example: Tranfering from alice to bob
    //1. Alice balance decreases in the transaction
    //2. Bobo balance increases in the transaction
    function testTransferAliceToBob() public {
        
        uint256 _ammountToTransfer = 100;

        //Check that bob balance is zero at the beginning
        
        uint256 _inititalBobBalance = token.balanceOf(bob);
        assertEq(_inititalBobBalance, 0);

        // Send some minted tokens to alice from the contract owner
        token.transfer(alice, _ammountToTransfer);
       
        // Now alice has balance 
        uint256 _inititalAliceBalance = token.balanceOf(alice);
        assertEq(_inititalAliceBalance, _ammountToTransfer);

        // Alice now makes the transfer
        vm.startPrank(alice);
        token.transfer(bob, 60);
        assertEq(token.balanceOf(alice), 40);

        // Check bob now recieves the transfer
        assertEq(token.balanceOf(bob), 60);

    }
}

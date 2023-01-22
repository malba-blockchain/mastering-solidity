//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract PlatziFood {

    constructor() {}
    //Object platzi food item with its parameters
    struct PlatziFoodItem {
        address owner;
        string foodUrl;
        string foodName;
        string originCountry;
    }

    //Object that will store the array of platzi foods
    PlatziFoodItem [] private platziFoods;

    //Function to add a new item in the array
    function addPlatziFood( string memory foodUrl, string memory foodName, string memory originCountry) public {
        platziFoods.push(
            PlatziFoodItem(msg.sender, foodUrl, foodName, originCountry)
        );
    }
    
    //Function to retrun all foods form the array
    function getAllPlatziFoods() public view returns (PlatziFoodItem[] memory) {
        return platziFoods;
    }

    //Function to get all the foods of an owner
    function getPlatziFoodsByOwner() public view returns (PlatziFoodItem[] memory) {
        uint itemCount = 0;

        //Make a loop to find out the size of the array to return
        for (uint256 i=0; i<platziFoods.length; i++) {
            if(platziFoods[i].owner == msg.sender) {
                itemCount++;
            }
        }

        //The array is created based on the size of the previous loop
        PlatziFoodItem[] memory myfoods = new PlatziFoodItem[](itemCount);
        uint nextPosition = 0;
        for (uint256 i=0; i<platziFoods.length; i++) {
            if(platziFoods[i].owner == msg.sender) {
                myfoods[nextPosition] = platziFoods[i];
                nextPosition++;
            }
        }
        return myfoods;
    }
    

}
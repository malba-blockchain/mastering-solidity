const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Counter Contract", () => { //Declare the test for the contract
    
    it("Should increment the counter", async() => { //Define an specific test case
        const Counter = await ethers.getContractFactory("Counter"); //Make the asociation with the smart contract to test
        const counter = await Counter.deploy(0); //Deploy the smart contract with its initial value

        await counter.increment(); //Execute a function

        const updatedCounter = await counter.getCounter(); //Get the function that is going to be tested
        expect(updatedCounter).to.equal(1); //Make the test
        
    });


    it("Should change the value of the counter", async() => { //Define an specific test case

        const Counter = await ethers.getContractFactory("Counter"); //Make the asociation with the smart contract to test
        const counter = await Counter.deploy(0); //Deploy the smart contract with its initial value

        await counter.setCounter(1000); //Execute a function

        const updatedCounter = await counter.getCounter(); //Get the function that is going to be tested
        expect(updatedCounter).to.equal(1000); //Make the test
        
    });
});
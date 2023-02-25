const {ethers} = require("hardhat");

import "hardhat/console.sol";

async function main () { //Create the main function to deploy
    const [deployer] = await ethers.getSigners(); //Get the addresses of the signers of the transaction
    console.log("Deployer: ", deployer);

    const Counter = await ethers.getContractFactory("Counter"); //Make the asociation with the smart contract to test
    const counter = await Counter.deploy(0); //Deploy the smart contract with its initial value

    console.log("Counter Contract Address", counter.address); //Get the address property of the smart contract

}

main () //Launch the function, everything goes well or it throws an error
    .then(()=> process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
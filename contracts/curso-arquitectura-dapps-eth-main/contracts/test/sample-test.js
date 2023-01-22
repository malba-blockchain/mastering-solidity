const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PlatziFood", function () {
  it("Add a new dish", async function () {

    //get a pair of accounts to test and make transactions
    const [owner, addr1] = await ethers.getSigners();

    //Create the contract factory object to later deploy it
    const PlatziFood = await ethers.getContractFactory("PlatziFood");

    //Contructor is empty because there are not params to send
    const platziFood = await PlatziFood.deploy();

    //Wait until the line gets fully executed then continue
    await platziFood.deployed();

    var addFood = await platziFood.addPlatziFood(
      "https://eatyourworld.com/images/content_images/images/gallo—pinto.jpg",
      "Gallo Pinto", 
      "Costa Rica"
    );
    //Wait until the minting gets finished in the blockchain
    await addFood.wait();

    //Launch another test. If you dont specify which account to use, it will always use owner
    var addFood2 = await platziFood.connect(addr1).addPlatziFood(
      "https://eatyourworld.com/images/content_images/images/gallo—pinto.jpg",
      "Gallo Pinto", 
      "Costa Rica" 
    );
    await addFood2.wait();

    //Launch another test, using the other function
    var foods = await platziFood.getAllPlatziFoods();

    //Test using expect function
    expect(foods.length).to.equal(2);

    //Launch another test using the function with params
    var foodsByOwner = await platziFood.connect(addr1).getPlatziFoodsByOwner();

    expect(foodsByOwner.length).to.equal(1);
  });
});

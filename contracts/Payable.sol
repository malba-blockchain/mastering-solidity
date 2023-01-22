// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ownable {

    address public ownable;

    constructor() {
        ownable = msg.sender;
    }

    modifier onlyOwner { //Modifiers. We use modifiers to make validations. Its like an if shaped like a function
        require(msg.sender==ownable,"Not the charity. Don't have permission to move the funds");
        _;
    }
}

contract Payable is Ownable { //Heritage in Solidity

    //have a public registry of donations
    mapping (address => uint) public balanceOf;

    //Add the payable atribute to be able to recieve criptocurrency
    //This value gets stored in the smart contract address, not in the deployer address
    function deposit() payable public {
        //We keep record of the donationsvia mapping
        balanceOf[msg.sender] = msg.value;
    }

    //Get the ability to transfer the funds stored in the charity smart contract to the deployer of the smart contract
    function withdraw() public onlyOwner {
        payable(ownable).transfer(address(this).balance);
    }

}
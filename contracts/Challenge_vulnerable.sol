//SPDX-License-Identifier:  MIT
pragma solidity >=0.8.0 <0.9.0; //Never use a fixed version, NEVER

contract Challenge_vulnerable {
    
    address owner;
    mapping(address => uint) balances;

    constructor() {
        owner = msg.sender;
    }

    function mint(uint amount) public {
        require(owner == msg.sender, "The user is not the owner");
        balances[msg.sender] += amount;
    }

    function depositar() public payable{
        balances[msg.sender] += msg.value; 
    }

    function retirar() public {
        require(balances[msg.sender] > 0);
        uint monto = balances[msg.sender];
        
        balances[msg.sender] = 0 ; //This must be executed before the transaction
        (bool success, ) = msg.sender.call{value:monto, gas:10000}(""); //Its neccesary to put a gas limit in the transaction
        if (!success) revert(); //If there is no success, revert the transaction
    }
}
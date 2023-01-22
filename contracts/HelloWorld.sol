// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HelloWorld {

    string phrase;

    constructor() public { //Constructor only gets executed whenthe contract is instanciated
        phrase = "Hello world";
    }

    function setPhrase(string memory _phrase) public {
        phrase = _phrase;
    }

    //The value that is returned is memory. That means its not required to save its value in the smart contract
    function getPhrase() public view returns (string memory _phrase) {
        return phrase;
    }

}
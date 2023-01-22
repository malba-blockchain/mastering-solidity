// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Conditionals {

    int public counter;

    constructor () {
        counter = 0;
    }

    function YesOrNo (bool input) public {
        if(input) {
            counter++;
        } else {
            counter--;
        }
    }

}
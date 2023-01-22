// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Loops {

    uint[] public data;

    function repeat(uint number) public {
        for (uint i=0; i<=number; i++)
        {
            data.push(i);
        }
    }

    function getData() public view returns(uint[] memory _data) {
        return data;
    }

}
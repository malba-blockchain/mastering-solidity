// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MiTokenNoFungible is ERC721 ("Mi Token No Fungible", "MTNF") 
{
    constructor() {
        _mint(msg.sender, 1); //En este caso, en lugar de mintear una cantidad, se mintea un ID
    }

}

//ERC-1155: Trabajar con más de un token en el mismo contrato. Cada token tiene un ID diferente
//Pero estos tokens pueden ser fungibles y no fungles
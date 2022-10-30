// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Authentication {

    mapping (address => bool) public users; //Crea un diccionario de direcciones vs estado de autenticación TRUE o FALSE

    //Función authenticate que permite registrar la address del usuario que se quiere autenticar y asignar TRUE
    function authenticate () public { 
        users[msg.sender] = true;
    }

}
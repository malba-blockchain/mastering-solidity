 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

 contract Gas {

    //Gas: Meddida para definir el poder de computo que es necesario para ejecutar una acción
    //El gas va a variar según el uso de la red. El precio se da en Ether
    //Gas total = (Gas x precio de gas) + gas fee al minero

     uint public numero;

     function asignarNumero (uint entrada) public {

         numero = entrada;
     }

 }

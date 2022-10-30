// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Modificadores {

    //Modificadores. Son bloques de código que permiten ejecutar código al inicio de una función
    //Normalmente están relacionados con condiciones o restricciones

    //En este caso, quiero que solo el que hizo el deploy del contrato pueda ejecutar la suma

    address private owner;

    string private nombreOwner;

    constructor (string memory nombre){

        owner = msg.sender; //EL que lanza el contrato se identifica con msg.sender
        nombreOwner= nombre;
    }

    //Este modifier valida si el que está enviando la transacción es el mismo que el owner 
    //Los modifiers son como triggers que se activan cuando algo va mal
    modifier isOwnerAddress() {
        if (msg.sender != owner) revert();
        _; //
    }


    //MANEJO DE ERRORES
    //Assert: permite evaluar un valor. Es utilizado principalmente para hacer pruebas de contratos
    //Revert: interrupe la ejecución de una función y revierte todos los cambios realizados hasta el momento
    //Requiere: Evalua una condición y en caso de no cumplirar ejecuta un revert. Puede mostrar un mensaje

    //Se debe poner el revert lo más antes posible en el código.  Porque igual se consumirá procesamiento 

    modifier isOwnerAddress2() { //Requiere es lo que espero que se cumpla
        require(msg.sender == owner, "El usuario no es el creador del contrato");
        _;
    }

    //La función debe llevar el modifier como método antes del returns
    function Suma (uint numero1, uint numero2) public view isOwnerAddress2() returns (uint) {

        return numero1 + numero2;
    }


}

  
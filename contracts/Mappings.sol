// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Saldo {

    //Mappings: Permite almacenar información en formato clave:valor y no tiene que ser el mismo tipo
    //bastante util cuando tienes identificadores únicos para la información

    mapping (address => uint) public balance; //Una dirección y el valor del balance

    //Enum se usa para enumerar estados en una lista
    enum Estado {Iniciado, Finalizado} //El enum no lleva punto y coma

    Estado public estadoDelContrato; //El estado público se setea despues de definir el tipo

    constructor () {

        estadoDelContrato = Estado.Iniciado;

        balance[msg.sender] = 1000; //Uso la dirección del sender para setear los valores

        estadoDelContrato = Estado.Finalizado;
    }

    //Enums: Tipo de dato personalizado. Una sucesión de valores creados por el usuario
    //Son representados externamente por un nombre, pero internamente por un valor entero
    


}
   

 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;


//Interface con el nombre de la interface
interface Suma{
    //Función que suma 2 números
    function sumar(uint numero1, uint numero2) external returns(uint);

}
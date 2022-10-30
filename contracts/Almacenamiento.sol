// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Almacenamiento {

    //Tipos de almacenamiento
    //Storage: Almacenamiento dentro del contrato
    //Memory: Almacenamiento de tipo temporal. Como un iterador. Costo menor al storage
    //Calldata: Es donde se alojan los parámetros y su comportamiento es similar al de memory


    string private nombre;

    constructor (string memory palabra) {

        nombre = palabra;
    }

}



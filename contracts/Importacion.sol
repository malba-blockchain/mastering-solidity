 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

//No es necesario reinventar la rueda. Tan solo es necesrio importar la librería correcta
//La importación se hace con la sentencia import
//Una libería no guarda estados ni variables. Solo provee utilidad
//Realiza operaciones con la informacióin suministrada

//En lugar de contract se usa la palabra library

contract Importacion {

    function sumarNumeros(uint numero1, uint numero2) public pure returns (uint) {
        return numero1 + numero2;
    }

     function sumarNumerosSafe(uint numero1, uint numero2) public pure returns (uint) {
        return SafeMath.add(numero1,numero2);
    }

}


// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
//ESTRUCTURAS DE DATOS:
//EnumerableSet: Parecido a un array. Pero para eliminar y añadir elementos no tiene que ser el ultimo. Permite validar duplicados
//Recibe el set sobre el que se quiere trabajar y el valor sobre el que se quiere operar. 
//Permite también validar si se contiene un elemento
//Permite validar la longitud y saber donde se encuentra un elemento
//EnumerableMap: Parecido a un mapping

contract Enumerable {

    using EnumerableSet for EnumerableSet.AddressSet;

}


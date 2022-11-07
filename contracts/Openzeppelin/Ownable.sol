// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
//Ownable: Contrato que controla el acceso a las funciones para que solo su dueño (owner) pueda ejecutarlas.
// El owner puede ser modificado
contract MiContrato is Ownable { //Is para determinar la herencia

    function funcionAccesiblePorTodos() public {

    }

    function functionParaElOwner() public onlyOwner { 

    }
}




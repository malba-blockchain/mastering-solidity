// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

//ACCESSCONTROL: Contrato que permite definir diversos roles para restringir
//el acceso a las funciones de modo que se asignen a uno o más roles

contract ContratoConRoles is AccessControl {

    //Se hashea el string del rol que los humanos entienden y luego se pasa a byte32
    bytes32 public constant ROL_ADMIN = keccak256("ROL_ADMIN"); 
    bytes32 public constant ROL_USUARIO = keccak256("ROL_USUARIO");

    constructor () {
        _grantRole(ROL_ADMIN, msg.sender);
    }

    function soloAdmin() public  {
        require(hasRole(ROL_ADMIN, msg.sender), "Esta funcion solo puede ser usada por el ADMIN");
    }

    function soloUsuario() public  {
        require(hasRole(ROL_USUARIO, msg.sender), "Esta funcion solo puede ser utilizada por un USUARIO");
    }

    function agregarRol (bytes32 role, address account) public {

        require(hasRole(ROL_ADMIN, msg.sender), "Esta funcion solo puede ser utilizada por el admin");
        _grantRole(role,account); //Función que se hereda de access control
    }
}

//TimelockController: Agrega una demora a la ejecución de una función de parte de un usuario con permisos (ADmins)
//Para que en caso de que exista un conflicto, haya tiempo de actuar
//Esto añade mayor seguridad y confianza a los contratos
//Se pueden también hacer llamadas con delay a otro contrato
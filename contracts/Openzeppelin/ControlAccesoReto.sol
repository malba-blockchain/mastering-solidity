// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract ControlAccesoReto is AccessControl{

    uint256 number;
    //Implementa dos roles: Admin y Writer
    bytes32 constant ROL_ADMIN = keccak256("ROL_ADMIN");
    bytes32 constant ROL_WRITER = keccak256("ROL_WRITER");

    constructor () {
        //Da el rol admin a quien inicia el contrato
        _grantRole(ROL_ADMIN, msg.sender);

    }

    //Modifiers para validar roles
    modifier isWriter()  {
        require(hasRole(ROL_WRITER, msg.sender), "El usuario no tiene el rol WRITER para ejecutar la funcion Storage");
        _;
    }

    modifier isAdmin()  {
        require(hasRole(ROL_ADMIN, msg.sender), "El usuario no tiene el rol ADMIN para ejecutar la funcion de garantizar o revocar permisos");
        _;
    }

    //Funciones para dar o quitar permisos de writer
    function agregarWriter (address cuenta) public isAdmin {
        _grantRole(ROL_WRITER, cuenta);

    }

    function quitarWriter (address cuenta) public isAdmin {
        _revokeRole(ROL_WRITER, cuenta);
    }

    //Función que quiero usar con permisos de Writer
    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) isWriter public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}
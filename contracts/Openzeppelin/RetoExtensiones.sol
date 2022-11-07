// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol"; //FUncionalidad para quemaar sin enviar a otra dirección
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RetoExtensiones is ERC20Burnable, Pausable, Ownable { //Las herencias se separan por coma

    constructor () ERC20Burnable() ERC20("Desafio Extensiones", "DE")
    {
        _mint(msg.sender, 100000);
    }

    function PauseContract () public onlyOwner { //Función para pausar el contrato
        _pause();
    }

    function UnpauseContract () public onlyOwner {
        _unpause();
    }

    //En realidad no se pone la dirección por que es el sender propietario el que quema
    function BurnToken (uint amountToBurn) public  { 
        require(paused() != true, "El contrato esta pausado, no se puede ejecutar esta funcion");
        burn(amountToBurn);
    }


}

//Utilidades: Matemáticas seguras.
//De la versión 0.8 en adelante son seguras, pero versiones antiguas necesitan safeMath
//SafeMath es la librería que se usa para comprobar overflows. 
//Se usan todas las operaciones matemáticas con esta librería

//CRIPTOGRAFÍA: Contratos que verifican firmas e información relacionada con la red a través de algoritmos complejos
//Para hacer estos chequeos se usa la función verify

//ECDSA: La función recover se usa para intenta recuperar la dirección relacionada a una firma
//toEthSignedMessageHash: Se puede tomar el mensaje y la dirección para validar el mensaje firmado

//ESCROW: Contratos que gestionana depósitos y retiros de fondos de parte de los usuarios
//Conditional Escrow: Permitir retiros una vez cumplida una condición
//Refund Escrow: Pensado en varios depósitos que luego solo una cuenta puede retirar. Ej. Beneficiencia




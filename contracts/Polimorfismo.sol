 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

import "./Interface.sol";

contract Polimorfismo {

    function sumarDesdeContrato(uint numero1, uint numero2, address direccionContrato) 
        public returns(uint){
            //Se obtiene la dirección del contrato y se convierte en una instancia de interface
            Suma interfaceSuma  = Suma(direccionContrato);

            //Se ejecuta la función pero haciendo uso del contrato
            return interfaceSuma.sumar(numero1, numero2);
    }
}
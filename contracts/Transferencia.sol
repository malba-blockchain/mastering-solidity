 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract Transferencia {
    //Transferencia de Ether desde un contrato
   //Call: Envía un monto de Ether a una dirección y retorna el resultado de la operación
 
    //Send y transfer requieren que las direcciones sean de tipo payable. Call no lo requiere
    //Send y transfer tienen un límite de gas de 2300

    
    //Asignar el tipo payable indica al contrato que se enviarán fondos

    //La unica forma de realizar transacciones desde los contratos es desde el contrato en si mismo
    //Por eso no se especifica la cuenta del usuario que acciona el contrato
    //Para realizar una transacción, primero se deben dar los fondos al contrato

    constructor () payable { //hacer el contrato payable, indica que se podrán enviar saldos desde su creación

    }
    //Send:Envía un monto de ether a una dirección. Retorna false si no pudo hacerlo
    
    function transferenciaPorSend(address destino, uint monto) public returns (bool) {
        bool salida = payable(destino).send(monto);
        return salida;
    }

    //Transfer:Envía un monto de ether a una direción. Interrumpe la ejecución si no puede realizarlo
 
    function transferenciaPorTransfer(address destino, uint monto) public {
        payable(destino).transfer(monto);
    }

    //Call no tiene tope, pero se puede establecer
    //Call permite llamar a funciones si la dirección especificada es un contrato
    //Se recomienda principalmente usar Call para poder delimitar la cantidad pagar por gas
    function transferenciaPorCall(address destino, uint monto) public returns (bool) {
        (bool salida, bytes memory respuesta) = destino.call{value:monto}("");
        return salida;
    }


}


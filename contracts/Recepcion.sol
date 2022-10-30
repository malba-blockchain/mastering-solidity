 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

    //Recibir Ether desde un contrato

  
    //Cuando se envía una transferencia, lo primero que se intenta verificar es si existe una función con la firma especificada
    //Si no se encuentra, se buscará una función fallback que reciba parámetros

contract Recepcion {

    uint public saldoEnviado;

    mapping(address => uint) balances;

    //Recieve: FUnción opcional que se ejecuta cuando se recibe una transferencia de ether SIN parámetros. Transferencia limpia
    //Si lo mando desde el campo que está cerca de deploy se usa esta función, ya que va limpia
    receive() external payable {
        balances[msg.sender] += msg.value; //Value contiene la información de cuanto se transfirió
    }

    //Fallback: Función opcional que se ejecuta cuando se rebibe una transferencia de ether CON parámetros
    //Si lo mando desde un método del contrato usa esta función
    fallback() external payable { 
        //Los parámetros de fallback se obtienen a través de msg.data

    }

    //Funcion payable: Se puede recibir Ether en una función si se le especifica el tipo payable

    function recibirSaldo(uint numero) public payable {
        saldoEnviado = msg.value;
        
        uint monto = msg.value;
        
        monto =  numero;
    }
}

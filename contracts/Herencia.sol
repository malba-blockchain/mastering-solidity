 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

import "./Interface.sol";

import "./Modificadores.sol";

//HERENCIA: Reutilizar código que ya está escrito en un contrato para optimizar recursos
//Solitidy no es un lenguaje orientado a objetos. Es orientado a contratos


//Se indica por medio de la sentencia IS.  Si un contrato tiene un constuctor con parámetros, debemos indicar
//qué valores debe t omar ese constructor para poder derivarse

//OVERRIDE: Se indica en una función cuando esta se redefine (ya está escrita)
// Para definir que una función puede ser redefinida se debe llamar VIRTUAL 

//ABSTRACTO: Si una fución virtual no define implementación, el contrato se convierte en un contrato abstracto

//Interfaces: Definen el comportamiento que queremos que tenga un contrato. Solo contiene declaraciones y encabezados, no implementación

//SUPER: permite llamar funciones literales que están escritas en el contrato anterior

contract Herencia is Suma, Modificadores {

//Las funciones públicas de los contratos que heredan aparecen dentro del nuevo contrato
//Si el constructor de la que hereda tiene parámetros, el constructor del nuevo contrato también pedirá esos parámetros
    constructor(string memory nombreNuevo) Modificadores(nombreNuevo) {
        
    }

    //Esta funcion pertenece al contrato interface, se pone el override y el modificador isOwnerAddress que pertenece a Modificadores.sol
    function sumar(uint numero1, uint numero2) public override isOwnerAddress2() view returns(uint)
    {
        return numero1 + numero2;
    }
    

}

//Instanciar un contrato en otro contrato. Dentro de un contrato podemos hacer referencia a otro contrato ya implementado en la red, a través de su dirección
//Se puede utilizar el tipo de contrato referencido o clases superiores
//Polimorfismo: Capacidadad de usar contratos derivados en estructuras superiores: Vehículo: Carro-helicoptero-yate

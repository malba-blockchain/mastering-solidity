// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Funciones {

    //Las funciones son piezas de código que pueden ser invocadas desde otras partes del contrato o fuera del mismo
    //Tienen la capacidad de retornar valores o alterar el estado del contrato
    //Cuando retornan valor se les llama función. Cuando no lo hacen se les llama procedimiento

    //public-private-internal-external
    //view: solo lectura no modifica el estado del contrato - pure: no acceden a las variables del contrato

    //Cuando la función es pure, se pone la palabra pure despues del estado publico/privado y antes del return
    //Hacer esta alacarón genera una mejora en el performance

    function Suma(uint numero1, uint numero2) public pure returns (uint) {

        return SumaInterna( numero1,  numero2);

    }


    uint private resultado;


    function SumaInterna(uint numero1, uint numero2) private pure returns(uint) {

        return numero1 + numero2;
    }

    //En este caso la función se llama view, ya que no modifica ninguna variable

    function ObtenerResultado() public view returns (uint) {

        return resultado;
    }

}


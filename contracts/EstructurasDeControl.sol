// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EstructurasDeControl {

//Una vez mas se utiliza la etiqueta public para poder interacturar con estas variables del contrato

    uint [] public numero;

    string public resultado;    

    //Si el usuario no mira el detalle de la transacción en el explorador no tiene forma de validar que se ejecutó
    //para eso existen los eventos. Se encargan de notificar lo que sucediío

    //Primero se declara el nombre del evento y el tipo de dato que retorna
    event NotificacionDeCondicion(bool condicion);

    event ValorDeSigno(uint signo);

    constructor(bool condicion, uint signo) {

        //Es necesario tener en cuenta la cantidad de estos condicionales
        //Entre más estructuras de control, mayor el precio del gas a pagar
        //Ojo sobre todo cuando hay blucles
        if(condicion){
            resultado = "Condicion True";
        }
        else {
            resultado = "Condicion False";
        }

        //Para lanzar el evento se usa el prefijo emit con el nombre del evento y el parámetro a notificar

        emit NotificacionDeCondicion(condicion);
        //El evento lanzado se identificará en el detalle de las transacciones, en el apartado logs

        for (uint iterador = 0; iterador<10; iterador++){
            numero.push(iterador); //Agregar de 1 en 1 los elementos del array
        }

        emit ValorDeSigno(signo);

    } 
}

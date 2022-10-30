// SPDX-License-Identifier: GPL-3.0

//Siempre es apropiado tener un rango de 2 versiones
pragma solidity >=0.7.0 <0.9.0;

//Declara el contrato con la palabra contract. Un .sol puede tener más de 1 contrato adentro. Pero se recomienda un contrato por archivo
//Normalmente lleva el mismo nombre del archivo
contract Estructura {

    
    //En solidity no hay decimales. Hay booleanos, address, int, uint, string y bytes. Una cadena sin formato específico
    //Bytes se usa para guardar claves y hashes

    //Hay tres tipos de variables 1. las state variables: las que persisten y quedan almacenadas permanentementes (costoso de almacenar)
    //2. Local variables: las que son temporales
    //3. Variables globales: 
    //msg (valores relacionados con la configuración del mensaje) 
    //tx (valores relacionados con la transacción actual) De donde se originó la transacción y quien llama la transacción
    //block (valores relacionados con el bloque actual) 
    int cantidad;
    int cantidadSinSigno;
    address direccion;
    bool firmado;


    //La función constructor no es obligatoria pero facilita la carga de datos al inicio del contrato
    
    constructor (bool estaFirmado) {
        direccion = msg.sender; //Asigna la dirección del que inicia la transacción
        firmado = estaFirmado;
    }

} 
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 

contract ImplementandoUnTokenERC20 is ERC20 {

    constructor (string memory name, string memory symbol) ERC20 (name, symbol) { //En este caso los parámetros se reciben antes de lanzarlos
        //Se usa elevedo a la cantidad de decimales para que se creen la cantidad real de tokens
        //La función decimals indica la cantidad de decimales que tiene el token
        _mint(msg.sender, 100000*(10**decimals())); //Se usa el _ cuando se trata de una función interna
    }

    //Si se quiere cambiar la cantidad real de decimales se puede usar la función decimals
    function decimals() public pure override returns (uint8) {
        return 6;
    }
}

//Contratos actualizables
//Patrón proxy: Un contrato funciona como proxy que va a reenviar todos los llamados a una versión específica del contrato que contiene la lógica de la función que se quiere ejecutar
//El contrato proxy hace un mapeo 1 a 1 de cada una de las funciones del contrato de la lógica.
//No obstante, su mantenimiento es complejo. Se necesita desplegar 2 contratos con cada cambio y se pierde el estado almacenado
//Se usa la función fallback para enviar transacciones
//Hay contato proxy y contrato logica

//El contrato proxy necesita almacenar los datos del contrato de la logica al cual va a redirigir data
//Al hacerse esto, el contrato proxy ocupa espacios de memoria, también la lógica necesita estos espacios

//Se pueden generar colisiones de almacenamiento. Estas variables se ejecutan sobre el contexto del proxy.
//Patrón de almacenamiento desestructurado: Soluciona el problema de colisiones
//El proxy almacena la informacipn en un espacio aleatoriamente 
//EIP 1967: Estandariza los espacios en memoria que usarán los proxis para almacenar la información que requieren
//Transparent proxy: El próxy tiene la lógica para actualizar y administrar el contrato
//UUPS: El contrato con la lógica contiene las funciones para actualizar y administrar el proxy
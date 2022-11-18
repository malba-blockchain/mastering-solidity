// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Función transferFrom: Util en casos donde se interactúa con contratos que funcionan como vendedores
//Estos no tienen forma de escuchar eventos que generan las transacciones

//Ataque front running: Forma de explotar el transfer from
//Se lanza una transacción que compite contra otra que está a punto de ser validada
//Esta transacción se hace pagando un fee mucho más alto para poder ser validada primero
//Al final se ejecuta la transacción del atacante primero y también la ultima de la victima

//Funciones Increase y Decrease allowance: No asignan directamente el valor a aprobar como con aprove
//Sino que aumentan o disminuyen ese valor.
//Hooks: Funciones que se ejecutan antes de determinadas acciones
//Para el ERC-20 hay hooks antes y despues de transferir tokens
//Permiten inyectar lógica en las funciones sin necesidad de sobre escribirlas
//Los tokens hijos hacen llamados de los hooks de los padres


 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

//Tokens: SOn una representación de un elemento que tiene un valor en un contexto determinado
//Esta representación tiene menos valor que el objeto original
//Existen diferentes clasificaciones para los tokens

//Fungibles: Son elementos reemplazables por otros con las mismas características
//No fungibles: Son elementos que pueden variar de valor respecto de elementos de iguales características. No son divisibles.

//ERC-20: Estandar para representar tokens fungibles
//ERC-721: Estandar para representar tokens no fungibles

//TokenURI: Contiene información no técnica acerca de un token

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenFungible is ERC20("TokenFungible", "TF") {

    constructor() {
        _mint(msg.sender, 1000); //La cantidad que se asigne será la que se genera
    }
}

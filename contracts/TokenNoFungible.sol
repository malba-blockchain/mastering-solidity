 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TokenNoFungible is ERC721("TokenNoFungible", "TNF") {
   
   constructor(){
    _mint(msg.sender, 1); //El ID que se ponga en el mint del ERC721 va a ser un elemento nuevo
   }

}

//ABI: Application Binary Interface
//No se tiene el contenido de las funciones. Solo sus encabezados
//Viene en formato json. Permite saber que forma tiene un contrato para interactuar con sus funciones
//Especialmente si estamos construyendo la capa de usuario
//ABI es lo que aparece en la carpeta artifacts
//En el json se sube también el byte code. El cual se puede decodificar al formato original
//Por lo tanto es vital no subir  información sensible en el código en el texto plano



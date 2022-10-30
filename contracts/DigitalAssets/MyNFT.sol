// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC721/ERC721.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; //Importar todo el código creado por openzeppelin
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; //Almacenar la URI del token, la metadata del NFT

contract MyNFT is ERC721URIStorage {

    uint private _tokenIds; //Asigna que ID se va a asignar cada vez que un user quiera nuestro NFT
    address owner; //Definir quien desplegó el contrato y es el owner

    modifier onlyOwner() {

        require(msg.sender == owner, "Only owner can authorize users");
        _;
    }

    constructor() ERC721 ("MyNFT", "NFT") { //Crea el nombre del token y pasa un simbolo
        owner = msg.sender; //Asigna al owner la dirección de quien está desplegando el contrato
    }

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner returns (uint256) { //Recibe la wallet del nuevo dueño y la URI
        //Función que permite asignar a un usuario el NFT dentro de la blockchain
        _tokenIds = _tokenIds + 1; //Aumenta la cantidad de tokens existentes
        _mint(recipient, _tokenIds); //Añadir al balance de la cuenta el token generado
        _setTokenURI(_tokenIds, tokenURI); //Relaciona el token ID con el token URI

        return _tokenIds;
    }

}
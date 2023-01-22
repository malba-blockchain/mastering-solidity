// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./PlatziPunksADN.sol";

//Se puede usar el wizard de open zeppelin para componer smart contracts basado en extensiones y en características a añadir

//Se pueden construir Data URLs, toda la información de la imagen está contenida en base 64

//El token ERC721 ya hereda las funciones de metadata

//Cuando una función es privada, esto se define con el _

//Oráculos como chainlink mueven el procesamiento no determinista oofchain y cobran un fee por reinsertarlo en la blockchain.
//Se hace posible consumir informacipon y realizar calculos 

contract PlatziPunks is ERC721, ERC721Enumerable, PlatziPunksADN
{

    using Counters for Counters.Counter; //Importa la librería de counters

    Counters.Counter private _idCounter; //Identificador de los nfts
        
    uint256 public maxSupply; //Limita la cantidad de tokens a mintear

    mapping(uint256  => uint256) public tokenDNA;

    constructor (uint256 _maxSupply) ERC721("PlatziPunks", "PLZPKS") {
            maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = _idCounter.current(); //Contador para el id de los nfts minteados
        require (current < maxSupply, "No PlatziPunks left");
        //Crear el DNA pseudo aleatoriamente para mintear el NFT
        tokenDNA[current] = deterministicPseudoRandomDNA(current, msg.sender);
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    function _baseURI() internal pure override returns(string memory) {
        return "https://avataaars.io/";
    }

    function _paramsURI(uint256 _dna) internal view returns (string memory) {
        string memory params;

            {
            params = string(
                abi.encodePacked(
                    "accessoriesType=",
                    getAccessoriesType(_dna),
                    "&clotheColor=",
                    getClotheColor(_dna),
                    "&clotheType=",
                    getClotheType(_dna),
                    "&eyeType=",
                    getEyeType(_dna),
                    "&eyebrowType=",
                    getEyeBrowType(_dna),
                    "&facialHairColor=",
                    getFacialHairColor(_dna),
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna),
                    "&topType",
                    getTopType(_dna)
                )
            );
        }

        return params;
    }

    function imageByDNA(uint256 _dna) public view returns (string memory) {
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);
        return string(abi.encodePacked(baseURI, "?", paramsURI));
    }

    //Esta función retorna el token URI para un tokenId dado
    //Con las funciones tipo view no se tiene que pagar GAS, solo cuando se modifica el estado de la blickchain
    function tokenURI(uint256 tokenId) public view override returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721 Metadata: URI query for nonexistent token"
        );

        uint256 dna = tokenDNA[tokenId];

        string memory image = imageByDNA(dna);

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "PlatziPunks #',
                tokenId,
                '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                image,
                '"}'
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

     // Override required
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal override (ERC721)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public view override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //Existen 13 atributos modificables diferentes para los platzi punks.
    //Su ADN será creado con base en una lista de 26 caracteres. 2 por cada atributo
    //Estos caracteres serán creados aleatoriamente en solidity
    //El cálculo de atributos se recorta la parte que nos interesa del ADN para convertirlo en un atributo

}
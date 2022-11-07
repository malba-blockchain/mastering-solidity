 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MultiToken is ERC1155 {
    
    uint256 public constant Fungible = 0;
    uint256 public constant NonFungible = 1;
    uint256 public constant OtroFungible = 2;

    constructor() public ERC1155 ("Aca una URI") {
        //El segundo parámetro es el ID de este token puntual
        //Wallet, ID, Cantidad, "parámetros para almacenar junto con cada token"
        _mint(msg.sender, Fungible, 1000, "");
        _mint(msg.sender, NonFungible, 1, "");
        _mint(msg.sender, OtroFungible, 5000, "");

    }
    //En este caso el balance se consulta con wallet y con ID

    //Existen extensiones para aumentar las funcionalidades de los smart contracts
    //Cada contrato da funcionalidades diferentes a cada tipo de Token. EJ. Burnable y pausable
    //ERC-777: Token fungible compatible con ERC-20. Pero con hooks: Funciones que se llaman automáticamente con transferencias
    //Value: ver el valor de la transferencia 
    
}
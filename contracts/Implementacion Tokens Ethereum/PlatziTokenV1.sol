// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Importar la versión actualizable del contrato ERC20
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol"; 

//Importar Ownable upgradeable para que el solo el dueño del contrato pueda actualizar
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

//Import the open proxy contract
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract PlatziTokenV1 is ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {

    //uso de un inicializador en vez de un constructor
    function initialize (uint256 initialSupply) public initializer {

        //Se usa el contrato ERC para inicializar
        __ERC20_init("PlatziToken","PLZ");

        //Inicializa el contrato ownable y el proxy
        __Ownable_init_unchained();
        __UUPSUpgradeable_init();

        //Se hace mint de la cantidad de tokens
        _mint(msg.sender, initialSupply*(10**decimals()));
    }

    //Sobreescribir esta función para que el proxy funcione
    function _authorizeUpgrade (address newImplementation) internal override onlyOwner
    { }

    //Min 5
}


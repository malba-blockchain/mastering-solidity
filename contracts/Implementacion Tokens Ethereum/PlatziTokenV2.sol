// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Importar la versión actualizable del contrato ERC20
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol"; 

//Importar Ownable upgradeable para que el solo el dueño del contrato pueda actualizar
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

//Import the open proxy contract
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract PlatziTokenV2 is ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {

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

    //Nueva función que solo puede ser ejecutada por el dueño del contrato
    function mint (address toAccount, uint256 amount) public onlyOwner {
        _mint(toAccount, amount);
    }
}

//Firmas OFF CHAIN
//Si se quieren hacer transacciones se debe no solo tener el token del contrato sino también el token de la red para pagar
//las transacciones. Es posible hacer intercambios sin hacer estos pagos.
//Se firma una estructura que represente la transacción. Esta estructura firmada la recibe una billetera diferente
//El contrato debe interpretar que la transacción tiene como origen la cuenta que firmó la transacción embebida
//Esto es posible con EIP 712: Estandariza el proceso de codificar estructuras que requieran ser firmadas offchain
//La especificación del EIP tiene esta definición

//EIP712 Separa los datos en 3 tipos:
//Atómicos: bytes 1 a bytes32. uint8 a uint256. int8 a int256. bool. address
//Dinámicos: bytes y strings
//Referencias: arrays y esctructuras




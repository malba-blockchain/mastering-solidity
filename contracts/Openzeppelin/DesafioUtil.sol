// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Importo los 3 tipos de contrato

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";

//Objetivos: Construir un contrato que reciba la dirección de un contrato
//ya implementado en la red e informar si pertenece a un ERC20 o ERC721

//INTROSPECCIÓN: Analizar contratos desde adentro.
//Contrato ERC 165. Contrato que verifica si otro contrato implementa o no otra interfaz
//Debe contar con la función "supportsInterface" definida en IERC165
//Tan solo es necesario proveer el ID de interface. type(IERC165).interfaceId;
//Sirve para validar contratos que hagan herencia
//ERC165Checker sirve para validar contratos externos a mi contrato, sobre sus direcciones

contract DesafioUtil {

    using ERC165Checker for address; //El using permite asignar las funciones de Checker a el tipo de atributo llamado address

    function esERC20(address direccionValidar) public view returns (bool) {
        bytes4 id = type(IERC20).interfaceId; 
        return direccionValidar.supportsInterface(id);
    }

    function esERC721 (address direccionValidar) public view returns (bool) {
        bytes4 id = type(IERC721).interfaceId;
        return direccionValidar.supportsInterface(id);
    }

}

//GOBERNANZA: La participación entre los usuarios del contrato. Estos contratos tienen contabilidad con compound
//La gobernanza también usa los timelocks para los cambios
//La gobernanza se da también a través de la cantidad de tokens existentes


//Contratos actualizables: El código que ya está almacenado en la blockchain no se puede modificar
//Un contrato se actualiza por:
//-Se encuentra un error en el código
//-Se quiere modificar la forma de hacer una operación u optimizar
//Upgradeable-contracts: No modifican el valor real, se usa un contrato intermediario llamado proxy
//Este contrato redirecciona sus llamadas a un contrato externo. Se implementan con truffle o hardhart
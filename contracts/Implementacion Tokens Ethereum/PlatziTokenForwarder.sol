// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol"; 

contract PlatziTokenForwarder is EIP712 {

    //Define la estructura de la meta transacción
    struct MetaTx {
        address from; //La dirección que está haciendo la firma offchain
        address to; //El contrato que queremos invocar
        uint256 nonce; //Entero sin signo para evitar ataques de replicación
        bytes data; //Codificación de la llamada a una función y sus parámetros de entrada
    }

    //Constante en la que se almacena el hash del tipo de la estructura
    bytes32 private constant _SIGNATURE_STRUCT_HASH = 
        keccak256 ("MetaTx(address from, address to, uint256 nonce, bytes data)");

    //almacena nonces usados por las diferentes cuentas para evitar ataques de repetición
    mapping(address => uint256) private _nonces;
 
    //Inicializa los contratos y envía los datos que serán parte del separador de dominio
    constructor() EIP712("PlatziTokenForwarder", "0.0.1") {}

    //Función para saber cual es el nonce actual para luego firmar 
    function getNonce(address from) public view returns (uint256) {
        return _nonces[from];
    }

    //Función para verificar la firma y saber si la meta transacción que se está ejecutando debe revertir o no
    function _verifyMetaTx(MetaTx calldata metaTx, bytes calldata signature)
        private
        view
        returns (bool)
    {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                    abi.encode(
                        _SIGNATURE_STRUCT_HASH,
                        metaTx.from,
                        metaTx.to,
                        metaTx.nonce,
                        keccak256(metaTx.data)
                    )
            )
        );

        //Se crea una dirección para obtener la firma de la meta transacción
        address metaTxSigner = ECDSA.recover(digest, signature);

        //Se compara la firma obtenida con la propiedad from de la meta transacción
        //Devuelve true si son iguales
        return metaTxSigner == metaTx.from;
    }

    //Esta es la función que ejecuta meta transacciones
    function executeFunction(MetaTx calldata metaTx, bytes calldata signature)
        public
        returns (bool)
    {
        //Se ejecuta la función anterior para verificar la firma
        //Si no da positivo este requiere se revierte
        require(
            _verifyMetaTx(metaTx, signature),
            "PlatziTokenForwarder: Invalid signature"
        );

        //Si la firma es válida, el nonce de la dirección se incrementa
        _nonces[metaTx.from] = metaTx.nonce + 1;

        //Se ejecuta la transacción codificada dentro de la transacción original
        //Se retorna un flag que indica si la transacción fue exitosa o no
        //Se agrega al final los 20 bytes que representan la dirección que hizo la firma offchain
        (bool success, ) = metaTx.to.call(
            abi.encodePacked(metaTx.data, metaTx.from)
        );

        return success;
    }


}

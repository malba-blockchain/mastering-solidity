// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Implementación del contrato EIP712
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol"; 

//Utilidades criptograficas para la verificación de firmas
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract EIP712MessageCounter is EIP712 {
    //Contadores, por cada mensaje enviado se aumenta la cuenta
    mapping (address => uint256) private _counters;
    //Guarda el ultimo mensaje enviado por una cuenta
    mapping (address => string) private _accountsLastMessage;

    //Estructura con la firma y un mensaje arbitratio
    struct Signature {
        address signer;
        string message;
    }

    //typeHash: Asigna a una constante el valor el hash
    bytes32 private constant _SIGNATURE_STRUCT_HASH =
        keccak256("Signature(address signer,string message)");

    //Inicializa en constructor no modificable. Nombre del dominio y versión
    constructor() EIP712 ("EIP712MessageCounter", "0.0.1") {}

    function _verifySignedMessage(
        Signature calldata signatureMessage,
        bytes calldata signature 
    ) private view returns (bool) {
        //calcula el hash de la estructura
        bytes32 digest = _hashTypedDataV4(
            // domainSeparator | hashStruct(S)
            keccak256(
                abi.encode( //Pasa el hash del tipo y las propiedades de la estructura
                    _SIGNATURE_STRUCT_HASH,
                    signatureMessage.signer,
                    keccak256(bytes(signatureMessage.message))
                )
            )
        );
        // Obtener mensajes y hacer comparación de quien hizo la firma. SI hay match la firma es correcta
        address messageSigner = ECDSA.recover(digest, signature);
        return messageSigner == signatureMessage.signer;
    }

    function setSignerMessage( //función para firmar el mensaje de forma offchain
        Signature calldata signatureMessage,
        bytes calldata signature
    ) public returns (bool) {
        require(
            _verifySignedMessage(signatureMessage, signature), //La verificación de las firmas debe ser correcta, sino se revierte
            "EIP712MessageCounter: Signature does not match expected Signature message"
        );

        _counters[signatureMessage.signer] =
            _counters[signatureMessage.signer] +
            1; 
        _accountsLastMessage[signatureMessage.signer] = signatureMessage
            .message;

        return true;
    }

    //oBTENER LA CUENTA DE UNA DIRECCIÓN
    function countOf(address account) public view returns (uint256) {
        return _counters[account];
    }
    //Obtener el ultimo mensaje
    function lastMessageOf(address account)
        public
        view
        returns (string memory)
    {
        return _accountsLastMessage[account];
    }
}

//Meta transacciones: Transacciones creadas y firmadas de manera off-chain por una cuenta y ejecutada por otra cuenta que paga por los fees de la red
//Es necesario que los contratos soporten meta transacciones para que estas se ejecuten correctamente
//EIP2771- Estandariza interfaz para contratos que soporten meta transacciones
//Trusted forwarder: Verifica la firma de la transaccion embebida y extrae la direccion que hizo la firma offchain
//Contrato destino: Extrae la cuenta orrigen del mensaje dependiendo de si es invocado por el trusted forwarder

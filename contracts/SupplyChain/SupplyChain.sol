// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SupplyChain {

    struct Step { //Guarda cada uno de los pasos que tiene este producto
        Status status;
        string metadata;
    }

    enum Status { //Estados posibles del producto
        CREATED,
        READY_FOR_PICK_UP,
        PICKED_UP,
        READY_FOR_DELIVERY,
        DELIVERED
    }

    event RegisteredStep ( //Evento para informar cada vez que se agregue un paso a un producto

        uint productId, //El producto 
        Status status, //Su status actual
        string metadata, //Su metadata
        address author //EL autor que registró ese paso
    );

    mapping (uint => Step[]) public products; //Relacionar un producto con cada uno de sus pasos

    function registerProduct(uint productId) public returns (bool success) { //Registrar un producto desde cero
        require (products[productId].length == 0, "This product already exists"); //Validar que no tenga productos asociados
        products[productId].push(Step(Status.CREATED,""));  //Asignar el paso del estado 0, created
        return success;
    }

    //Recibir el productID y la data que necesita ese paso
    function registerStep(uint productId, string calldata metadata) public returns (bool success) {
        //Valida que el producto exista: que tenga pasos asociados
        require(products[productId].length > 0, "This product doesn't exists");
        Step[] memory stepsArray = products[productId];
        uint currentStatus = uint (stepsArray[stepsArray.length - 1].status) +1;    
        //Valida que el ultimo paso que tenga no sea entregado/Delivered
        if (currentStatus > uint (Status.DELIVERED)) {
            revert("The product has no more steps");
        }
        //Asigna el ultimo estado definido
        Step memory step = Step(Status(currentStatus), metadata);
        //Añadirlo en el mapping de productos
        products[productId].push(step);
        //Lanzar el evento diciendo que se ha registaro un nuevo paso en el producto
        emit RegisteredStep(productId, Status (currentStatus), metadata, msg.sender);
        success = true;
    }
}
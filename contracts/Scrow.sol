// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Scrow is Ownable {

    address public comprador; //The person who buys the item
    address public vendedor; //The person who sells the item
   
    bool public depositoListo; //Checkmark if the deposit from the buyer is ready
    bool public compradorOK; //Checkmark if the buyer recieved the product
    bool public pagoListo; //Checkmark if the person who sells the item recieved the money

    uint public montoPago; //Value of the item that was bought

    modifier onlyBuyer() {
        require(msg.sender == comprador, "You are required to be the buyer");
        _;
    }

    constructor (address _comprador, address _vendedor, uint _montoPago) {

        comprador = _comprador;
        vendedor = _vendedor;

        montoPago = _montoPago;

        depositoListo = false;
        compradorOK = false;
        pagoListo = false;
    }

    //Function to deposit payment from the buyer to the scrow
    //Payable makes it able to recieve funds from an address to the smart contract
    function depositarPago () payable public onlyBuyer{
        require(msg.value == montoPago, "Wrong value for the transaction");
        depositoListo = true;
    }

    //Buyer recieved the item and confirms reciept
    function compradorConfirmaOK() public onlyBuyer {
        compradorOK = true;
    }

    //Function to move the payment from the scrow to the seller wallet
    function retirarPago() public {
        require(compradorOK, "The buyer has not approved the transaction yet");
        payable(vendedor).transfer(montoPago);
        pagoListo = true;
    }

    //If the buyer didn't recieved the product, the scrow makes intervention and gives back the funds
    function cancelarPorArbitro() public onlyOwner {
        payable(comprador).transfer(montoPago);
        pagoListo = true;
    }
}


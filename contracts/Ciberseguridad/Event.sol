// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Event {

    event newEventCreated(string _event);
    //Defino un evento que se lanza cada vez que un nodo lance un evento nuevo
    mapping(address => mapping (uint256 => string)) public events;
    //Almacena cuantos eventos en un nodo de esa blockchain
    mapping(address => uint256) public eventsCounter;
    //Threshold para limitar la cantidad de eventos en un nodo
    uint256 public threshold;
    //Almacenar el owner del contrato
    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "");
        _;
    }

    //Asigna el valor del treshold y el owner del contrato
    constructor(uint256 _threshold) {

        threshold = _threshold;
        owner = msg.sender;
    }

    //Recibe el evento
    function createEvent(string memory _event) public returns (bool success) {
        //AUmenta el contador para que cada evento tenga un ID unico
        uint256 eventId = eventsCounter[msg.sender] + 1;

        //Si el ID es mayor, re escribre los eventos
        if(eventId > threshold){
            eventId = 1;
        }
          //Acutaliza el contador   
          eventsCounter[msg.sender] = eventId;
          //Agrega el evento a la lista de eventos y su data
          events[msg.sender][eventId] = _event;
            //llama el evento para informar que fue agregado el evento
          emit newEventCreated(_event);
          success = true;
    }

    //Cambia el threshold por el dueño del contrato
    function setThreshold(uint256 _threshold) public onlyOwner {
        threshold = _threshold;
    }
  



}
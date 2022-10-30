// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract TokenBasic {

    string public constant name = "PlatziCoin"; //Nombre del token
    string public constant symbol = "PZC"; //El ticker el token
    uint8 public constant decimals = 18; //En cuantas fracciones se puede dividir
 
    uint256 _totalSupply; //Almacena cuantos tokens serán creados en total

    mapping (address => uint256) balances; //Cuantos tokens tiene una wallet en su balance
    mapping (address => mapping (address => uint256)) allowed; //Dada una wallet y otra B, cantidad que va a permitir la wallet A gestionar por parte de B

    event Transfer(address indexed _from, address indexed _to, uint256 _value); //Evento para ejecutar cada transferencia
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); //Evento creado cada vez que un owner permita a un spender gestionar sus tokens

    constructor (uint256 total){
        _totalSupply = total;
        balances[msg.sender] = total;
    }

    function totalSupply() public view returns (uint256) { //Devolver la cantidad total de supply del token
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint) { //Devolver el balance de la cuenta actual
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[msg.sender], "There are not enough fund to do the transfer"); //valida que hay suficientes platzi coins
        balances[msg.sender] = balances[msg.sender] - _value; //Restar el valor que se va a enviar al emisor
        balances[_to] = balances[_to] + _value; //Sumar el valor que se va a enviar al receptor
        emit Transfer(msg.sender, _to, _value); //Lanzar evento de transfer
        success = true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) { //Función para permitir a un spender gestionar cierta cantidad de tokens
        allowed[msg.sender][_spender] = _value; //Añadir cual wallet A permite a la wallet B gestionar cuantos tokes
        emit Approval(msg.sender, _spender, _value); //Lanzar evento de approval
        success = true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) { //Cuantos tokens le quedan por gestionar a esa wallet que ha sido autorizada por la wallet owner
        remaining = allowed[_owner][_spender]; //Cuantos tokens le quedan por gestionar a la wallet autorizada
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) { //Enviar tokens de una cuenta a otra
        require(_value <= balances[_from], "There are not enough funds to do the transfer"); //Validar que tiene tokens para transferir
        require(_value <= allowed[_from][msg.sender], "Sender not allowed"); //Validar que el usuario está autorizado

        //Restar del balance los tokens
        balances[_from] = balances[_from] - _value; //Resta del balance los tokens de la transferencia
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value; //Actualizar el mapping de allowed con los tokens que quedan
        balances[_to] = balances[_to] + _value;  //Añadir a la cuenta que recibe los tokens transferidos
        emit Transfer(_from, _to, _value); //Informa que hubo una transferencia
        success = true;
    }

}
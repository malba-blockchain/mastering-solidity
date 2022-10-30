// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Identity {

    //Información básica de contacto
    struct BasicInfo {
        string name;
        string email;
    }

    //Información personal
    struct PersonalInfo {
        uint salary;
        string _address;
    }

    //Tipos de acceso diferentes: Acceso a info básica o personal
    enum UserType {
        Basic,
        Personal
    }

    error UserUnauthorized(address user, UserType userType);

    //Variables para guardar información de la cuenta
    BasicInfo private basicInfo;
    PersonalInfo private personalInfo;
    address private owner;

    //Mapping de permisos para otorgar permisos de lectura a otras cuentas
    mapping (address => bool) private basicUsers; //Diccionario para guardar la lista de basic users
    mapping (address => bool) private personalUsers; //Diccionario para guardar la lista de personal users
    

    constructor (string memory name, string memory email, uint salary, string memory _address){
        basicInfo = BasicInfo(name, email); //Crea el elemento con los datos básicos
        personalInfo = PersonalInfo(salary, _address);  //Crea el elemento con los datos personales
        owner = msg.sender; //Definir quien es el owner del contrato
    }

    modifier authorizeUser(UserType userType){

        if(msg.sender == owner || personalUsers [msg.sender]){
            _;
        }
        else if(userType == UserType.Basic && basicUsers[msg.sender]){
            _;
        } else {
            revert UserUnauthorized(msg.sender, userType);
        }
    }

    modifier onlyOwner() { //Validar que solo el owner es quien registra usuarios
        require(msg.sender == owner, "Only owner can authorize users");
        _;
    }

    function getBasicInfo() public view authorizeUser(UserType.Basic) returns (BasicInfo memory) {
        return basicInfo;
    }

    function getPersonalInfo() public view authorizeUser(UserType.Personal) returns (PersonalInfo memory){
        return personalInfo; 
    }

    function registerUser(UserType userType, address user) public onlyOwner {

        if(userType == UserType.Basic){
            basicUsers[user] = true;
        } else if (userType == UserType.Personal) {
            personalUsers[user] = true;
        }
    }
}
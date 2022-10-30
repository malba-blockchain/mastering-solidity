// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding {

    enum FundraisingState {Opened, Closed} //Enum para asignar de forma limitada, solo 2 opciones el estado del proyecto

    struct Contribution {  //Struct para identificar las transacciones de contribución que se han realizado
        address contributor;
        uint value;
    } 

    struct Project {

        string id; //Identificador del proyecto
        string name; //Nombre del proyecto
        string description; //Detalle del proyecto de recolección de fondos
        address payable author; //Dirección de la wallet del creador del proyecot para que reciba fondos
        FundraisingState state; //Estado del proyecto
        uint funds; //Cantidad actual de fondos recolectados
        uint fundraisingGoal; //Meta de fondos
    }

    Project[] public projects; //Array para poder almacenar diversos proyectos
    mapping (string => Contribution[]) public contributions; //Array para poder almacenar diversas contribuciones

    event ProjectCreated( //Evento para notificar una vez un proyecto ha sido creado
        string projectId,
        string name,
        string description,
        uint fundraisingGoal
    );

    event ProjectFunded ( //Evento para notificar una vez se ha depositado en un proyecto
        string projectId,
        uint value
    );

    event ProjectStateChanged( //Evento para notificar una vez se cambió el estado de un proyecto
        string id,
        FundraisingState state
    );

    modifier isAuthor(uint projectIndex) { //Los modifiers son if optimizados. En este caso valida que la dirección sea de autor
        require(projects[projectIndex].author == msg.sender, "You need to be the project author"); //Los require son lo que esperas que se cumpla
        _;
    }

    modifier isNotAuthor(uint projectIndex) { //Los modifiers son if optimizados. Aqui valida que no sea autor para poder fondear el proyecto
        require(projects[projectIndex].author != msg.sender, "As author you can not fund your own project");
        _;    
    }

    function createProject(string calldata id, string calldata name, string calldata description, uint fundraisingGoal) public { //Usa los calldata como variable temporal no modificable, para optimizar consumo
        require(fundraisingGoal > 0, "Fundrasing goal must be greater than 0");
        Project memory project = Project(id, name, description, payable(msg.sender), FundraisingState.Opened,0, fundraisingGoal); //Crea el proyecto con los atributos de los parámetros
        projects.push(project); //Añade el proyecto a la lista de proyectos
        emit ProjectCreated(id, name, description, fundraisingGoal); //Lanza evento para notificar que ha sido creado
    }

    function fundProject (uint projectIndex) public payable isNotAuthor(projectIndex) {
        Project memory project = projects[projectIndex];
        require(project.state != FundraisingState.Closed, "The project can not receive funds"); //Si está cerrado no recibe
        require(msg.value > 0, "Fund value must be greater than 0"); //Se debe depositar una suma mayor a 0
        project.author.transfer(msg.value); //Realizar la transferencia del valor al autor
        project.funds += msg.value; //Se aumenta la cantidad que ahora el fondo tiene
        projects[projectIndex] = project;
    
        contributions[project.id].push(Contribution(msg.sender, msg.value)); //Crea la contribución creada y el que la envía
    
        emit ProjectFunded(project.id, msg.value); //Notifica el fondeo del proyecto
    }

    function changeProjectState(FundraisingState newState, uint projectIndex) public isAuthor(projectIndex) { //Cambia el estado del proyecto, con base en su índice, nuevo estado y si el que lo intenta cambiar es autor

        Project memory project = projects[projectIndex];
        require(project.state != newState, "New state must be different");
        project.state = newState;
        projects[projectIndex] = project;
        emit ProjectStateChanged(project.id, newState);
    }


}
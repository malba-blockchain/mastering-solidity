// SPDX-License-Identifier: GPL-3.0

//Siempre es apropiado tener un rango de 2 versiones
pragma solidity >=0.7.0 <0.9.0;


contract clase {

    //Struct: Tipo de dato que permite almacenar distintos tipos en un solo esquema.
    //Ej. Alumno: Nombre, apellido, edad, nota

    struct Alumno {

        string nombre;
        uint documento;
    }

    //Array: Cadena del mismo tipo de datos. Estáticos y dinámicos
    //Salvo algunas excepciones, es preferible mantener el tamaño del arreglo dinámico
    //De lo contrario pueden haber problemas, porque el smart contrar es inalterable
    
    //Solo se puede acceder a variables que han sido declaradas publicas
    Alumno [] public alumnos;

    //En el constructor cargas la información de arranque
    constructor(){
        //Se usa push para añadir al array indefinido
        //Dentro de la clase alumno se pueden ingresar datos estilo JSON
        //Se usa formato llave y valor
        alumnos.push(Alumno({nombre: "Juan", documento: 12345}));
    }

 

}
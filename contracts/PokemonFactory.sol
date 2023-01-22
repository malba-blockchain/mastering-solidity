//SPDX-License-Identifier:  MIT
pragma solidity >=0.8.0 <0.9.0;

contract PokemonFactory {
    //Optimization starts from the size of variables assigned in the type

    struct Pokemon {
        uint8 pokemonId;
        bytes16 pokemonName;
    }

    struct Ability {
        bytes16 abilityName;
        string abilityDescription;
    }
    
    //Optimization comes when you define if the type of the variable is memory or storage
    Pokemon[]  public  pokemons;

    //Mapping to correlate the id of the pokemon and the owner address
    mapping(uint8 => address) public pokemonToOwner;

    //Mapping to correlate the address of the owner and the amount of pokemons he has
    mapping(address => uint8) ownerPokemonCount;

    //Array of all abilities name - description
    Ability[] public allAbilities; 

    //Array of abilities of a specific pokemon: _pokemonId - ArrayOfuint8 (id of ability in the allAbilities array)
    mapping(uint8 => uint8[]) abilitiesOfAPokemon;

    //Array of all types
    bytes16[] public allTypes; 

    //Array of types of a specific pokemon: : _pokemonId - ArrayOfuint8 (id of type in the allTypes array)
    mapping(uint8 => uint8[]) typesOfAPokemon;

    //Array of all weaknesses
    bytes16[] public allWeaknesses; 

    //Array of types of a specific pokemon: : _pokemonId - ArrayOfuint8 (id of type in the allTypes array)
    mapping(uint8 => uint8[]) weaknessesOfAPokemon;

    event eventNewPokemon(Pokemon newPokemon); //Declare the event to launch


    //Local variables have underscore. Global variables dont, its a good practice
    function createPokemon (uint8 _pokemonId, bytes16 pokemonName) public {

        //Make some validations of the input before processing it
        require(_pokemonId>=0, "The ID value must be greater or equal than 0");
        require(bytes16(pokemonName).length >2,  "The name size must be greater than 2 characters");

        pokemons.push(Pokemon(_pokemonId, pokemonName)); //Add the new pokemon to the array
        pokemonToOwner[_pokemonId] = msg.sender; //Correlate the id of the pokemon with the user address
        ownerPokemonCount[msg.sender]++; //Increase the count
        emit eventNewPokemon(Pokemon(_pokemonId,pokemonName)); //Emit the event of new pokemon
    }
    
    /////////////////////////////SECTION OF ABILITIES //////////////////////////


    function AddAbility (bytes16 _abilityName, string memory _abilityDescription) public {
        allAbilities.push(Ability(_abilityName, _abilityDescription)); //Add to the ability array with the name and description
    }

    function GiveAbilityToPokemon (uint8 _pokemonId, uint8 _abilityId) public {
        //Make some validations of the input befor procesing it
        require(pokemonExists(_pokemonId), "The pokemon does not exist");
        require(abilityExists(_abilityId), "The ability does not exist");

        abilitiesOfAPokemon[_pokemonId].push(_abilityId); //Add the new ability to the array of abilities of a pokemon
    }

    //Function to validate if a ability exists, based on the return of the name size
    function abilityExists (uint8 _abilityId) private view returns (bool) {
        bytes16 tempName = allAbilities[_abilityId].abilityName;
        return bytes16(tempName).length >1;
    }

    //Return the array of abilities that a specific pokemon has
    function getAbilitiesOfAPokemon(uint8 _pokemonId) public view returns (uint8[] memory) {
        return abilitiesOfAPokemon[_pokemonId];
    }

    /////////////////////////////SECTION OF TYPES //////////////////////////

    function AddType (bytes16 _typeName) public {
        allTypes.push(_typeName); //Add to the types array with the name
    }

    function GiveTypeToPokemon (uint8 _pokemonId, uint8 _typeId) public {
        //Make some validations of the input befor procesing it
        require(pokemonExists(_pokemonId), "The pokemon does not exist");
        require(typeExists(_typeId), "The type does not exist");

        typesOfAPokemon[_pokemonId].push(_typeId); //Add the new type to the array of types of a pokemon
    }

    //Function to validate if a types exists, based on the return of the name size
    function typeExists (uint8 _typeId) private view returns (bool) {
        bytes16 tempName = allTypes[_typeId];
        return bytes16(tempName).length >1;
    }

    //Return the array of types that a specific pokemon has
    function getTypesOfAPokemon(uint8 _pokemonId) public view returns (uint8[] memory) {
        return typesOfAPokemon[_pokemonId];
    }


    /////////////////////////////SECTION OF WEAKNESSES //////////////////////////

    function AddWeakness(bytes16 _weaknessName) public {
        allWeaknesses.push(_weaknessName); //Add to the weakness array with the name
    }

    function GiveWeaknessToPokemon (uint8 _pokemonId, uint8 _weaknessId) public {
        //Make some validations of the input befor procesing it
        require(pokemonExists(_pokemonId), "The pokemon does not exist");
        require(weaknessExists(_weaknessId), "The weakness does not exist");

        weaknessesOfAPokemon[_pokemonId].push(_weaknessId); //Add the new weakness to the array of types of a pokemon
    }

    //Function to validate if a weakness exists, based on the return of the name size
    function weaknessExists (uint8 _weaknessId) private view returns (bool) {
        bytes16 tempName = allWeaknesses[_weaknessId];
        return bytes16(tempName).length >1;
    }

    //Return the array of weakness that a specific pokemon has
    function getWeaknessOfAPokemon(uint8 _pokemonId) public view returns (uint8[] memory) {
        return weaknessesOfAPokemon[_pokemonId];
    }

    //Function to validate if a pokemon exists, based on the return of the name size
    function pokemonExists (uint8 _pokemonId) private view returns (bool) {
        bytes16 tempName = pokemons[_pokemonId].pokemonName;
        return bytes16(tempName).length >1;
    }

    //Get all pokemons in existence
    function getAllPokemons () public view returns (Pokemon[] memory) {
        return pokemons;
    }

    //Get all abilities in existence
    function getAllAbilities () public view returns (Ability[] memory) {
        return allAbilities;
    }
}
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract donacionesOrg {
    address public propietario;
    uint256 public contadorOrganizaciones;
    address public direccionProhibida;

    constructor() {
        propietario = msg.sender;
        contadorOrganizaciones++;
        direccionProhibida;
    }

    // Mapping que asocia las direcciones de las organizaciones de caridad con sus nombres
    mapping(address => string) public organizacionesBeneficas;
    mapping(address => bool) public direccionRegistrada;


    // Evento que se emite cuando una organización de caridad se registra
    event registroOrganizacion(address caridad, string nombre);

    // Evento que se emite cuando un usuario realiza una donación
    event DonacionRealizada(address donante, address caridad, uint cantidad);

    
    struct Organizacion {
        string nombre;
        address direccion;
    }

    mapping(uint256 => Organizacion) public Organizaciones;

    function registrarOrganizacion(string memory _nombre, address _direccion) public {
        require(!direccionRegistrada[_direccion], "Esta direccion ya esta registrada");
        require(bytes(_nombre).length > 0 , "El nombre no puede estar vacio");
        // require(bytes(_direccion).length > 0,"La direccion no puede estar vacia");
        Organizaciones[contadorOrganizaciones] = Organizacion(_nombre, _direccion);
        direccionRegistrada[_direccion] = true;

        emit registroOrganizacion(msg.sender, _nombre);
        contadorOrganizaciones++;
    }

     // Función que permite a los usuarios realizar donaciones especificando la dirección de la organización de caridad y la cantidad de Ether que desean donar
    function donar(address _caridad, uint _cantidad) public payable {
        // Validación: la donación debe ser igual a la cantidad enviada
        require(msg.value == _cantidad, "La donacion debe ser igual a la cantidad enviada");
        // Validación: la donación debe ser un valor positivo
        require(_cantidad > 0, "La donacion debe ser un valor positivo");
        // Validación: la organización de caridad debe estar registrada
        require(bytes(organizacionesBeneficas[_caridad]).length > 0, "La organizacion de caridad no esta registrada");
        // Validación: el donante no debe ser la dirección prohibida
        require(msg.sender != direccionProhibida, "Esta direccion esta prohibida");
        // Transferir el Ether a la dirección de la organización de caridad
        payable(_caridad).transfer(_cantidad);
        // Emitir el evento de donación
        emit DonacionRealizada(msg.sender, _caridad, _cantidad);
    }
}




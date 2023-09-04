// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract nuevosProductos {
    address public propietario;
    uint256 public contadorProductos;

    struct Producto {
        string nombre;
        string descripcion;
        uint256 existencias;
        string caducidad;
        uint256 precio;
        // URL URL
    }
    mapping(uint256 => Producto) public Productos;
    mapping(string => bool) public nombreProductoRegistrado;

    constructor() {
        propietario = msg.sender;
        contadorProductos = 0;
    }

    modifier soloPropietario() {
        require(
            msg.sender == propietario,
            "Solo el propietario puede llamar a esto"
        );
        _;
    }

    function agregarProducto(
        string memory _nombre,
        string memory _descripcion,
        uint256 _existencias,
        string memory _caducidad,
        uint256 _precio
    ) public soloPropietario {
        contadorProductos++;
        require(
            !nombreProductoRegistrado[_nombre],
            "Este producto ya esta registrado"
        );
        require(bytes(_nombre).length > 0, "El nombre no puede estar vacio");
        require(
            bytes(_descripcion).length > 0,
            "La desripcion no puede estar vacia"
        );
        require(
            _existencias > 0,
            "El numero de existencias no puede estar vacio"
        );
        require(
            bytes(_caducidad).length > 0,
            "Ingrese la fecha de caducidad del producto"
        );
        require(_precio > 0, "El precio debe ser superior a 0");
        Productos[contadorProductos] = Producto(
            _nombre,
            _descripcion,
            _existencias,
            _caducidad,
            _precio
        );
        nombreProductoRegistrado[_nombre] = true;
    }
}
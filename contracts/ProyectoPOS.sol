// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract nuevosProductos {
    address public propietario;
    uint256 public contadorProductos;

     event ProductoAgregado(string nombre, string descripcion, uint256 existencias, string caducidad, uint256 precio);
     // Evento para notificar la compra de un producto.
    event CompraProducto(address comprador, string nombreProducto, uint256 cantidadComprada);

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

    constructor() payable  {
        propietario = msg.sender;
        contadorProductos = 0;
    }

    modifier soloPropietario() {
        require(msg.sender == propietario,"Solo el propietario puede llamar a esto");
        _;
    }

    function agregarProducto(string memory _nombre, string memory _descripcion, uint256 _existencias, string memory _caducidad, uint256 _precio) public soloPropietario {
        contadorProductos++;
        require(!nombreProductoRegistrado[_nombre], "Este producto ya esta registrado");
        require(bytes(_nombre).length > 0, "El nombre no puede estar vacio");
        require(bytes(_descripcion).length > 0, "La desripcion no puede estar vacia");
        require(_existencias > 0, "El numero de existencias no puede estar vacio");
        require(bytes(_caducidad).length > 0, "Ingrese la fecha de caducidad del producto");
        require(_precio > 0, "El precio debe ser superior a 0");

        Productos[contadorProductos] = Producto(_nombre, _descripcion, _existencias, _caducidad, _precio);
        nombreProductoRegistrado[_nombre] = true;
        emit ProductoAgregado(_nombre, _descripcion, _existencias, _caducidad, _precio);
    }

     // Función para comprar productos
    function comprarProducto(uint256 _productoId, uint256 _cantidad) public payable {
        require(_productoId <= contadorProductos && _productoId > 0, "Producto no encontrado");
        Producto storage producto = Productos[_productoId];
        require(producto.existencias >= _cantidad, "No hay suficientes existencias del producto");
        require(_cantidad > 0, "La cantidad debe ser mayor que 0");
        require(msg.value != producto.precio * _cantidad, "El valor enviado no coincide con el precio del producto");

        // Realiza la compra actualizando las existencias del producto.
        producto.existencias -= _cantidad;

        // Transfiere el Ether al propietario.
        payable(propietario).transfer(msg.value);

        // Emitir el evento de compra de producto.
        emit CompraProducto(msg.sender, producto.nombre, _cantidad);
    }
}

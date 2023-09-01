// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract enviarEth{

    address public propietario;

    struct Producto{
        string nombre;
        uint precio;
        uint cantidad;
    }
    mapping(string => Producto) public productos;

    constructor(){
        propietario = msg.sender;
    }

    //Modifier: Es una característica que te permite reutilizar y aplicar lógica específica antes o después de la ejecución 
    // de una o varias funciones en un contrato inteligente.
    modifier soloPropietario() {
        require(msg.sender == propietario, "Solo el propietario puede llamar a esto");
        _;
    }

    function agregarProducto(string memory _nombre, uint256 _precio, uint256 _cantidad) public soloPropietario {
        productos[_nombre] = Producto(_nombre, _precio, _cantidad);
    }

    function comprarProducto(string memory _nombre, uint256 _cantidad) public payable {
        // storage es una forma de almacenar datos de manera permanente en la cadena de bloques.
        Producto storage producto = productos[_nombre];

        //validamos si exiten productos
        require(producto.precio > 0, "Producto no encontrado");

        //validamos la cantidad que se envia alcanza el precio del producto
        require(_cantidad <= producto.cantidad, "Cantidad de producto insuficiente");

        //multiplicamos el precio del producto por la cantidad de productos que se quiere comprar
        uint256 costoTotal = producto.precio * _cantidad;
        
        //Validamos si los fondo que se envia son suficiente para comprar la x cantidad de productos
        require(msg.value >= costoTotal, "Fondos insuficientes");

        //Restamos la cantidad de productos disponible
        producto.cantidad -= _cantidad;
    }

    // este fragmento de código se encarga de rechazar las transacciones de ether
    //  que no están destinadas a la función de compra adecuada 
    // y proporciona una guía para que los usuarios utilicen la función correcta.
    receive() external payable {
        revert("Usa la funcion: comprarProducto");
    }
  

}



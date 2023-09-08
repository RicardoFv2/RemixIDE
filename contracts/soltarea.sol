// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract ProductoContract {
    //contador(ID) registros.
    uint256 public ProductoCounter = 0;

    event ProductoCreated(
        // uint256 id,
        string nombre,
        string descripcion
        // bool done,
        // uint256 creatAt
    );

    constructor() payable {
        
    }

    event CambioDeMiTarea(uint256 _id, bool estado);

    //Definir lista
    struct Producto {
        // uint256 id;
        string nombre;
        string descripcion;
        // bool done;
        // uint256 creatAt;
    }

    mapping(uint256 => Producto) public Productos;

    function createProducto(string memory _nombre, string memory _descripcion)public{
        ProductoCounter++;
        Productos[ProductoCounter] = Producto(_nombre,_descripcion);

        emit ProductoCreated(_nombre,_descripcion);
    }

    // function cambioEstado(uint256 _id) public {
    //     Producto memory _Producto = Productos[_id]; //buscando tarea

    //     _Producto.done = !_Producto.done; //Cambiando estado

    //     Productos[_id] = _Producto; //Actualiza elemento

    //     emit CambioDeMiTarea(_id, _Producto.done);
    // }
}

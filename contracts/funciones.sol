// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Ejemplo{

    function sumar(uint32 a, uint32 b) public pure returns (uint32){
        return a + b;
    }

    function restar(uint32 a , uint32 b) public pure returns(uint32){
        return a - b;
    }

    function multiplicar (uint32 a , uint32 b) public pure returns (uint32){
        return a * b;
    }

    function dividir(uint32 a, uint32 b) public pure returns (uint32){
        require(b != 0, "No se puede dividir entre 0");
        return a / b;
    }

    function saludar(string memory nombre, string memory apellido)public pure returns (string memory){
        return string(abi.encodePacked("Hola ", nombre,' ', apellido));
        // return string.concat("Hola", nombre,' ', apellido);

    }

    //View: No modifica los datos pero si accede a ellos
    uint256 x = 100;
    function obtenerNumero() public view returns (uint256){
        return x *2;
    }

    address propietaro;
    constructor(){
        propietaro = msg.sender;
    }

    function obetenerPropietario() public view returns (address){
        return propietaro;
    }

}
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract eviarEth{

    //Transfer | send | call

    constructor() payable {}

    receive() external payable {}

    event estadoEnvio(bool);

    function enviarViaTransfer(address payable _direccion) public payable{
        _direccion.transfer(1 ether);

    }

    function enviarViaSend(address payable _direccion) public payable{
        bool resultado = _direccion.send(1 ether);
        //El metodo send nos devolvera un false o true si ha sido enviado correctamente
        emit estadoEnvio(resultado);
        require(resultado == true, "El envio ha fallado");

    }
                                     

    event llamadoEstado(bool, bytes);
    function enviarViaCall(address payable _direccion) public payable {
        (bool estado, bytes memory data) = _direccion.call{value:1 ether}("");
        emit llamadoEstado(estado,data );
        require(estado == true, "El envio ha fallado");



    }
    
}

contract recibirEth{

    event log(uint256 monto, uint256 gas);
    receive() external payable {
        emit log(address(this).balance, gasleft());
    }

}
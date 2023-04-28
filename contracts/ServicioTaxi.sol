// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ServicioTaxi {
    address payable public conductor;
    address payable public cuentaEmpresa;
    uint256 public precioPor100Metros;
    uint256 public valorBanderazo;
    uint256 public valorEspera;
    uint256 public recargoFestivo;
    uint256 public carreraMinima;

    constructor(address payable _conductor, address payable _cuentaEmpresa, uint256 _precioPor100Metros, uint256 _valorBanderazo, uint256 _valorEspera, uint256 _recargoFestivo, uint256 _carreraMinima) {
        conductor = _conductor;
        cuentaEmpresa = _cuentaEmpresa;
        precioPor100Metros = _precioPor100Metros;
        valorBanderazo = _valorBanderazo;
        valorEspera = _valorEspera;
        recargoFestivo = _recargoFestivo;
        carreraMinima = _carreraMinima;
    }

    function calcularPrecio(uint256 distancia, uint256 tiempoEspera, bool esFestivo) public view returns (uint256) {
        uint256 precio = valorBanderazo;

        // Calcular precio por distancia
        precio += distancia / 100 * precioPor100Metros;

        // Calcular precio por tiempo de espera
        precio += tiempoEspera / 24 * valorEspera;

        // Aplicar recargo festivo
        if (esFestivo) {
            precio += recargoFestivo;
        }

        // Aplicar carrera mínima
        if (precio < carreraMinima) {
            precio = carreraMinima;
        }

        return precio;
    }

    function contratar(uint256 distancia, uint256 tiempoEspera, bool esFestivo) public payable {
        uint256 precio = calcularPrecio(distancia, tiempoEspera, esFestivo);
        require(msg.value >= precio, "No se ha enviado suficiente ETH.");

        // Enviar el pago a la cuenta de la empresa
        cuentaEmpresa.transfer(msg.value);
    }

    function contratarMasDe10Dias(uint256 distancia, uint256 tiempoEspera, bool esFestivo) public payable {
        uint256 precio = calcularPrecio(distancia, tiempoEspera, esFestivo);
        require(msg.value >= precio * 9 / 10, "No se ha enviado suficiente ETH para el descuento.");
        
        // Enviar el pago a la cuenta de la empresa
        cuentaEmpresa.transfer(msg.value);
    }

    function contratarUnMes(uint256 distancia, uint256 tiempoEspera, bool esFestivo) public payable {
        uint256 precio = calcularPrecio(distancia, tiempoEspera, esFestivo);
        require(msg.value >= precio * 7 / 10, "No se ha enviado suficiente ETH para el descuento.");
        
        // Enviar el pago a la cuenta de la empresa
        cuentaEmpresa.transfer(msg.value);
    }
}

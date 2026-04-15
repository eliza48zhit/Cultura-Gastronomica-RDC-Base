// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaRDC
 * @dev Registro de elasticidad de masas y viscosidad de salsas oleaginosas.
 * Serie: Sabores de Africa (25/54) - HITO: MEDIA EXPEDICION.
 */
contract CulturaRDC {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 elasticidadFufu;    // Capacidad de deformacion elastica (1-10)
        uint256 viscosidadSalsa;    // Resistencia al flujo de la Moambe (1-10)
        bool usaNuezPalmaNatural;   // Validador de extraccion artesanal de lipidos
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Pollo Moambe (Plato Nacional e Ingenieria de Viscosidad)
        registrarPlato(
            "Poulet a la Moambe", 
            "Pollo, salsa de nuez de palma fresca, espinacas (o Saka-Saka), ajo.",
            "Extraer el aceite de la pulpa de nuez de palma y reducir hasta lograr una viscosidad que recubra la proteina.",
            0, 
            9, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _elasticidad, 
        uint256 _viscosidad,
        bool _nuez
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_elasticidad <= 10 && _viscosidad <= 10, "Escalas de 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            elasticidadFufu: _elasticidad,
            viscosidadSalsa: _viscosidad,
            usaNuezPalmaNatural: _nuez,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 elasticidad,
        uint256 viscosidad,
        bool nuez,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.elasticidadFufu, p.viscosidadSalsa, p.usaNuezPalmaNatural, p.likes);
    }
}

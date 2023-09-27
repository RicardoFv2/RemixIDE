// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract TaskContract{

    //contador(ID) registros.
    uint public taskCounter = 0;

    event TaskCreated(
        uint id,
        string title,
        string description,
        bool done,
        uint creatAt
    );

    event CambioDeMiTarea(uint _id, bool estado);
    

    //Definir lista
    struct Task{
        uint id;
        string title;
        string description;
        bool done;
        uint creatAt;
    }

    mapping ( uint256 => Task ) public tasks;

    function createTask(string memory _title, string memory _description) public {

        taskCounter++;
        tasks[taskCounter] = Task(taskCounter, _title, _description, false, block.timestamp);

        emit TaskCreated(taskCounter, _title, _description, false, block.timestamp);

    }

    function cambioEstado(uint _id) public {

        Task memory _task = tasks[_id];//buscando tarea

        _task.done = !_task.done;//Cambiando estado

        tasks[_id] = _task;//Actualiza elemento

        emit CambioDeMiTarea(_id, _task.done);
    }

//INICIO CONTRATO PARA AGREGAR PRODUCTOS AL INVENTARIO

    address public owner;
    uint256 public productCount;

    struct Product {
        uint256 id;
        string name;
        string description;
        uint256 stock;
        string expirationDate;
        uint256 price;
    }

    mapping(uint256 => Product) public products;

    event ProductAdded(uint256 productId, string name, string description, uint256 stock, string expirationDate, uint256 price, address seller);
    event ProductPurchased(uint256 productId, string name, uint256 quantity, uint256 totalPrice, address buyer);

    constructor() {
        owner = msg.sender;
        productCount = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function addProduct(string memory _name, string memory _description, uint256 _stock, string memory _expirationDate, uint256 _price) public onlyOwner {
        require(bytes(_name).length > 0, "Product name cannot be empty");
        require(bytes(_description).length > 0, "Product description cannot be empty");
        require(_stock > 0, "Product stock must be greater than 0");
        require(bytes(_expirationDate).length > 0, "Product expiration date cannot be empty");
        require(_price >= 0, "Product price cannot be negative"); // Updated validation

        productCount++;
        products[productCount] = Product(productCount, _name, _description, _stock, _expirationDate, _price);
        emit ProductAdded(productCount, _name, _description, _stock, _expirationDate, _price, msg.sender);
    }

    function purchaseProduct(uint256 _productId, uint256 _quantity) public payable {
        require(_productId > 0 && _productId <= productCount, "Invalid product ID");
        Product storage product = products[_productId];
        require(product.stock >= _quantity, "Not enough stock available");
        require(msg.value == product.price * _quantity, "Incorrect payment amount");

        // Transfer the payment to the seller
        payable(owner).transfer(msg.value);

        // Update the stock of the product
        product.stock -= _quantity;

        emit ProductPurchased(_productId, product.name, _quantity, msg.value, msg.sender);
    }

    function getProductDetails(uint256 _productId) public view returns (string memory name, string memory description, uint256 stock, string memory expirationDate, uint256 price){
        require(_productId > 0 && _productId <= productCount, "Invalid product ID");
        Product storage product = products[_productId];
        return (product.name, product.description, product.stock, product.expirationDate, product.price);
    }
}



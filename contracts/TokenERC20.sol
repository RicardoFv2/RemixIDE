// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external view returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external view returns (bool);

    function transferFrom(address from, address to, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract ERC20 is IERC20 {

    mapping (address => uint256) private balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _nameToken;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        nameToken = name;
        symbol = symbol;
    }

    function name() public view virtual returns (string memory){
        return  _nameToken;
    }

    function symbol() public view virtual returns (string memory){
        return _symbol;
    }

    function decimls() public view virtual returns (uint256){
        return 18;
    }

    function totalSupply() public view virtual returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256){
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool){
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns 
}
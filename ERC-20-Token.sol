// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//ERC Token Standard
interface ERC20Interface {
    function totalSupply() external view returns (uint);
    function balanceOf (address account) external view returns (uint balance);
    function transfer(address recipient, uint amount) external returns (bool success);
    function allowance(address owner, address spender) external view returns (uint remaining);
    function approve(address spender, uint amount) external returns (bool success);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool success);
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    }

//Actual token contract
contract Token is ERC20Interface {
    string public symbol;
    string public name;
    uint8 public decimals = 18;
    uint public _totalSupply;

    mapping(address => uint)balances;
    mapping(address => mapping(address => uint))allowed;

    constructor(){
        symbol = "QUE";
        name = "Quecko Coin";
        decimals = 18;
        _totalSupply = 1_000_001_000_000_000_000_000_000; //A million + 1 coins,with 18 zeros for decimal points
        balances[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = _totalSupply;
        emit Transfer (address(0),0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,_totalSupply);
       }



    function totalSupply() public view returns (uint){
        return _totalSupply;
    }

    function balanceOf(address account) public view returns ( uint balance) {
        return balances[account];
    }

    function transfer( address recipient, uint amount) public returns ( bool success) {
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }

    function approve(address spender, uint amount) public returns (bool success) {  
        allowed[msg.sender][spender] = amount;  
        emit Approval(msg.sender,spender,amount);
        return true;  
    }   

    function transferFrom(address sender, address recipient, uint amount) public returns (bool success) {
        balances[sender] = balances[sender] - amount;
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;  
        emit Transfer(sender,recipient,amount);  
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint remaining) {
        return allowed[owner][spender];
    }
}
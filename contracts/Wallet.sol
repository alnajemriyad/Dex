// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Wallet is Ownable {

  using SafeMath for uint256;

// a struct that defines tokens.
  struct Token {
    bytes32 ticker;
    address tokenAdress;
  }


//Mapping that allows to find a Token struct by using the thcker.
  mapping(bytes32 => Token) public tokenMapping;
  
// An array to store supported tokens
  bytes32[] public tokenList;

// Mapping to find ballances of a user, using the user address and atoken ticker.
  mapping (address => mapping(bytes32 => uint256)) public balances;

// Modifier that checks if if the token is supported by the contract before executing a function.
  modifier tokenExist (bytes32 ticker){
  require(tokenMapping[ticker].tokenAdress != address(0), "Token is not supported");
  _;
}

// a function to add tokens to the list of supported tokens, can only be done by the owner.
  function addToken(bytes32 ticker, address tokenAdress) onlyOwner external {
    tokenMapping[ticker] = Token (ticker, tokenAdress);
    tokenList.push(ticker);
  }

// a function to deposit an ERC20 tokken to this contract.
  function deposit (uint amount, bytes32 ticker) tokenExist(ticker) external {
    IERC20(tokenMapping[ticker].tokenAdress).transferFrom(msg.sender, address(this), amount);
    balances[msg.sender][ticker] = balances[msg.sender][ticker].add(amount);
  }

// a function to withdraw an ERC20 from this contract. 
  function withdraw (uint amount, bytes32 ticker) tokenExist(ticker) external {
    require(balances[msg.sender][ticker] >= amount, "Balance not sufficiant!");
    balances[msg.sender][ticker] = balances[msg.sender][ticker].sub(amount);
    IERC20(tokenMapping[ticker].tokenAdress).transfer(msg.sender, amount);
  }

}

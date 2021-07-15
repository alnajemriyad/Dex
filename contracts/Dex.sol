// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./Wallet.sol";

contract Dex is Wallet {
  
  enum Side {
    Buy,
    Sell
  }

  struct Order {
    uint id;
    address trader;
    Side orderType;
    bytes32 ticker;
    uint amount;
    uint price;
  }

  mapping(bytes32 => mapping(uint => Order[])) public orderBook;

  function getOrderBook(bytes32 ticker, Side orderType) view public returns(Order[] memory) {
    return orderBook[ticker][uint (orderType)];
  }
}

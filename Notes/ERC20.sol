// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ERC20 {
  string public name;
  string public symbol;

  // "balanceOf" is part of the ERC20 specification
  // This means the function balanceOf can be called on the contract,
  // supply an address and get how many tokens the address owns
  mapping(address => uint256) public balanceOf;
  address public owner;
  uint8 public decimals;

  uint256 public totalSupply;

  constructor (string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
    decimals = 18;

    owner = msg.sender;
  }
  // general practice to use params "to" and "amount" for "mint()"
  function mint(address to, uint256 amount) public {
    require(msg.sender == owner, "only owner can create tokens");
    totalSupply += amount;
    balanceOf[owner] += amount;
  }
  // ERC20 requires a public function or variable called totalSupply 
  // in order to know how many tokens have been created
  function transfer(address to, uint256 amount) public {
    require(balanceOf[msg.sender] >= amount, "you ain't rich enough");
    // No one "owns" address zero address, tokens sent there are
    // un-spendable. By convention, sending a token to the zero address
    // should reduce the totalSupply
    require(to != address(0), "can't send to address(0)");
    balanceOf[msg.sender] -= amount;
    balanceOf[to] += amount;
  }
}
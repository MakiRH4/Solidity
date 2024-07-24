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
	// ERC20 requires a public function or variable called totalSupply 
	// in order to know how many tokens have been created
	uint256 public totalSupply;

	mapping(address => mapping(address => uint256)) public allowance;

	constructor (string memory _name, string memory _symbol) {
		name = _name;
		symbol = _symbol;
		decimals = 18;

		owner = msg.sender;
	}
	// general practice to use params "to" and "amount" for "mint()"
	function mint(address to, uint256 amount) public {
		require(msg.sender == owner, "only owner can create tokens");
		require(totalSupply + amount <= 1_000_000 * 10**18, "exceeds maximum supply")
		totalSupply += amount;
		balanceOf[owner] += amount;
	}

	//Function helperTransfer() has to be INTERNAL
	function helperTransfer(address from, address to, uint256 amount) internal returns (bool) {
		require(balanceOf[from] >= amount, "not enough money");
		require(to != address(0), "cannot send to address(0)");
		balanceOf[from] -= amount;
		balanceOf[to] += amount;

		return true;
	}

	function transfer(address to, uint256 amount) public returns (bool) {
		return helperTransfer(msg.sender, to, amount);
	}

	function approve(address spender, uint256 amount) public returns (bool) {
		allowance[msg.sender][spender] = amount;
		
		return true;
	}

	function transferFrom(address from, address to, uint256 amount) public returns (bool) {
		if (msg.sender != from) {
			require(allowance[from][msg.sender] >= amount, "not enough allowance");
			require(to != address(0), "cannot send to address(0)");
			balanceOf[from] -= amount;
			balanceOf[to] += amount;

			return true;
		}
	}
}
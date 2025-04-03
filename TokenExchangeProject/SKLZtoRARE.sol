// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract SkillzCoin {

	string public name;
	string public symbol;
    string public extraStuff;
    address public owner;
    uint256 public _totalSupply;

    //used to store the balnce of tokens to each address
	mapping(address => uint256) public balanceOf;

    //used to store the allowance between addresses
    mapping(address => mapping(address => uint256)) public allowance;

	constructor(string memory _extraStuff) {
        name = "Skillz";
        symbol = "SKLZ";
        extraStuff = _extraStuff;
        owner = msg.sender;
        _totalSupply = 0;
	}

    //used to get ballance, mainly needed for outside the contract calls on balanceOf
    function getBalance(address from) public view returns (uint256) {
        
        return balanceOf[from];
    }

    //used to mint tokens, anyone can mint
	function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
        _totalSupply += amount;
	}

    //used to burn tokens, only token owner can burn them
    function burn(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "not enough funds");
        balanceOf[msg.sender] -= amount;
        _totalSupply -= amount;
    }

    //used to transfer tokens between accounts, can not transfer to address(0), only token owner can transfer
    function transfer(address to, uint256 amount) external {
        require(to != address(0), "unable to transfer tokens to 0x0");
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
    }

    //used to approve allowance to RareCoin contract
    function approve(address spender, uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "not enough tokens");
        allowance[msg.sender][spender] = amount;
    }
}

contract RareCoin {
        
    string  public  name;
    string  public  symbol;
    string  public  extraStuffRARE;
    address public  owner;
    uint256 public  _totalSupply;

    mapping(address => uint256) public balanceOf;
	
    constructor(string memory _extraStuffRARE) {
        name = "RareCoin";
        symbol = "RARE";
        extraStuffRARE = _extraStuffRARE;
        owner = msg.sender;
        _totalSupply = 0; 
	}

    function setBalance(address OxSkillzCoin, address from) external {
        (bool ok, bytes memory result) = OxSkillzCoin.call(abi.encodeWithSignature("getBalance(address)", from));
        require(ok, "calling getBalance failed");
        

        uint256 funds = abi.decode(result, (uint256));
        (bool burn_check, ) = OxSkillzCoin.call(abi.encodeWithSignature("burn(uint256)", funds));
        
        require(burn_check, "burn call failed");
        balanceOf[from] += funds;
        _totalSupply += funds;
        
    }

    //ANYONE CAN MINT, FIX IT!!
    //used to mint RARE, can only mint by burning SKLZ from SkillzCoin
    function mint(/* address OxSkillzCoin, */ address from, uint256 amount) external {
        //check SKLZ ballance
//        (bool ok, bytes memory result) = OxSkillzCoin.call(abi.encodeWithSignature("getBalance(address)", from));
//        require(ok, "calling getBalance failed");

//        uint256 funds = abi.decode(result, (uint256));
    
//        require(funds >= amount, "Not enough SKLZ");

        _mint(from, amount);

        }
    
    //core mint function, creates tokens and updates totalSupply, ther is no a MAXsupply
    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "can not mint to 0x0");
        balanceOf[to] += amount;
        _totalSupply += amount;
    }
/*
    function SkillzCoin.approve(address rareCoinAddress, uint256 SkillzBalance) private {
        //address of SkillzCoin contract
        address skillzCC;

        (bool ok, bytes memory amountApproved) =  skillzCC.call(abi.encodeWithSignature("SkillzCoin.balanceOf(address, uint256)", rareCoinAddress, SkillzBalance));
       require(ok, "call on SKLZ balance failed");
    }
    //mints x amount of RARE tokens to the address that's calling RareCoin contract
	function mint(address to, uint256 amount) external {
        require(amount <= SkillzCoin.balanceOf(to), "not enough SKLZ");
		_mint(to, amount);
        _burn(to, amount);
	}

*/
}

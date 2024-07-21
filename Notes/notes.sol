// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;


contract ExampleContract {

    uint256[] public myArray;
    string public name;

    function setMyArray(uint256[] calldata newArray) public {
        myArray = newArray;
    }

    function addToArray(uint256 newItem) public {
        myArray.push(newItem);
    }

    function removeFromArray() public {
        myArray.pop();
    }

    function getLength() public view returns (uint256) {
        return myArray.length;
    }

    function getEntireArray() public view returns (uint256[] memory) {
        return myArray;
    }
    //Removes an element at specified index, arrays length won't change
    function removeAt(uint256 index) public {
        delete myArray[index];
    }
    //Pops an element and replaces it with the last element in the array 
    function popAndSwap(uint256 index) public {
        uint256 valueAtTheEnd = myArray[myArray.length - 1];
        myArray.pop(); // reduces the length;
        myArray[index] = valueAtTheEnd;
    }
    //Strings can not be indexed, when called the entire string is returned
    function setName(string calldata newName) public {
        name = newName;
    }
}

//only the banker can change the balance due to the if statement, but anyone can view balances
contract ERC20Token {
    address public banker = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    mapping(address => uint256) public balances;

    function setSomeonesBalance(address owner, uint256 amount) public {
        if (msg.sender == banker) {
            balances[owner] = amount;
        }
        // do nothing
    }

    function transferTokensBetweenAddresses(address sender, address receiver, uint256 amount) public {
        if (msg.sender == banker) {
            balances[sender] -= amount;   // deduct/debit the sender's balance
            balances[receiver] += amount; // credit the reciever's balance
        }
        // do nothing
    }
}

//a smart contract's own address
contract ExampleContract {
    function whoami() public view returns (address) {
        return address(this);
    }
}

//calldata cannot be used in constructor arguments
//constructors cannot return values
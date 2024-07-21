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
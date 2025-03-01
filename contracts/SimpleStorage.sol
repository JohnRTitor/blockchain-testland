// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

// This is a contract
contract SimpleStorage {
    struct People {
        uint256 favoriteNumber; // indexed at 0
        string name; // indexed at 1
    }
    uint256 public favoriteNumber;

    People public person1 = People({favoriteNumber: 2, name: "John"});
    People public person2 = People({favoriteNumber: 4, name: "Mike"});
    // however, this just goes on and on, let's just use an array to get people as a list

    // this is a dynamic array, though we can give it a size by using
    // People[5] to give it a size of 5
    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber + 1;
    }

    // deployed address: 0xd9145CCE52D386f254917e481eB44e9943F39138
    // ^ ^ taken at the time of first deploying this

    // view function does not allow modification of blockchain
    // does not use any gas
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
}



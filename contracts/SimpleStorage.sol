// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

// This is a contract
contract SimpleStorage {
    // uint256 favoriteNumber = 5;
    uint256 public favoriteNumber;
    /*
    uint256 testNum; // This gets initilised to zero

    bool hasFavoriteNumber = true;
    string favoriteNumberInText = "Five";
    int256 favoriteInt = -5;
    address myAddress = 0x0587e50A345B6A17097A18b76483C49383aD8995;
    bytes32 myBytes = "Hello World";
    */

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
    // pure does not allow read of blockchain either
    function retrieve_2 () public pure returns(uint256) {
        return (1 + 1);
    }
}



// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

// This is a contract
contract SimpleStorage {
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    uint256 public favoriteNumber;

    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber + 1;
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // we can explicitly provide the parameters
        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // people.push(newPerson);

        people.push(People(_favoriteNumber, _name));
    }
}



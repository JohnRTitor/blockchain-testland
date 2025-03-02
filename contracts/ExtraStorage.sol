// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// Inheritance
// ExtraStorage is child contract of SimpleStorage contract
contract ExtraStorage is SimpleStorage {
    // overriding the function from SimpleStorage
    // the function needs to be virtual for it to be overridable
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber;
    }
}
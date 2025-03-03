// We need to
// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    uint256 public minimumUsd = 50;

    function fund() public payable  {
        // We need to set a minimum fund amount in USD
        // if we use the require function, we can let the whole operation fail
        // if we don't have the required funds
        require(msg.value > 1e18, "Didn't send enough"); // 1e18 = 1 * 10 ** 18
    }

    //function withdraw() {}
}
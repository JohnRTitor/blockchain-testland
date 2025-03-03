// We need to
// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {

    // to send funds we need payable keyword
    function fund() public payable  {
        // We need to set a minimum fund amount
        require(msg.value > 1e18, "Didn't send enough"); // 1e18 = 1 * 10 ** 18
    }

    //function withdraw() {}
}
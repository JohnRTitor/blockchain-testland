// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; // ^0.7.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        // unchecked keyword allows compiler errors and warnings to be suppressed
        // in this case it suppresses the error
        // bigNumber is a 8bit number with upper value limit is 255
        // if we add 1 to it it should become 256, but since uint8 can't hold that large value
        // it reverts back to 0, this wasn't the case for solidity compilers < 8
        // where it would instantly revert back to 0
        // so to replicate this behaviour on version 8+, we need to disable compiler checking
        // note that using unchecked also reduces gas cost
        // use it only for testing purposes or you are sure that your math is correct
        unchecked {bigNumber = bigNumber + 1;}
    }
}

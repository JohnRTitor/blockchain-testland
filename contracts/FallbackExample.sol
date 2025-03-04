// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // there are a few special functions in solidity
    // recieve and fallback don't need function keyword and args
    // constructor is also a special function

    /*
                    send Ether
                        |
            msg.data is empty?
                    /           \
                yes             no
                |                |
        receive() exists?     fallback()
            /        \
        yes          no
        |            |
    receive()     fallback()

    */

    // basically this means that if we send null calldata with some eth
    // we hit the receive() function, if we send an invalid calldata/invalid address to a function
    // then fallback() will be called

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}

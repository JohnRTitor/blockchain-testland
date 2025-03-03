// We need to
// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    // we need to specify this for it to work with uint256 objects
    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address =>  uint256) public addressToAmountFunded;

    function fund() public payable  {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function withdraw() public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);
        // actually withdraw the money
        // to send ether or money there are three ways

        // we must typecast an `address` to `address payable` to transfer it money

        // transfer - simpliest - automatically reverts and throws error if transfer fails
        // maximum of 2300 gas
        payable(msg.sender).transfer(address(this).balance);

        // send - returns bool
        // maximum of 2300 gas
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed.");

        // call - low level function that can call any function in solidity without the ABI
        // forwards all gas
        // call is the recommended way apparently
        (bool callSuccess, /* bytes memory dataReturned */) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed.");
    }
}
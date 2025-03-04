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

    address public owner;

    constructor() {
        // Constructor gets immediately called after deploying a contract
        owner = msg.sender;
    }

    function fund() public payable  {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed.");
    }

    // this is custom modifier, it is executed first if added to a functon declaration
    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner!");
        _; // do the rest of the code
    }
}
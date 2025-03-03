// We need to
// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address =>  uint256) public addressToAmountFunded;

    function fund() public payable  {
        // We need to set a minimum fund amount in USD
        // if we use the require function, we can let the whole operation fail
        // if we don't have the required funds
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough"); // 1e18 = 1 * 10 ** 18
        // msg.sender is the funder address who is sending us money
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function getPrice() public view returns (uint256) {
        // ABI
        // Address: ETH-USD 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // (uint80 roundId, int price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        // we only need the price
        (, int price, , ,) = priceFeed.latestRoundData();

        // Price is ETH in terms of USD
        // we know eth is like 2000

        // price is in 8 decimels
        // so normalize it to make it have 18 decimels
        return uint256(price * 1e10); 

    }
    
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();

        // to calculate eth amount in usd, as in 2$ worth of ETH
        // we can just multiply the price per eth and the amount
        // however ethPrice and ethAmount have 18 decimels both
        // so divide the result by 10^18, to get the correct result
        // in Solidity we always want to perform division after multiplication
        // addition, etc. Always at the end
        // In solidity we don't work with decimel much, as we can lose precision
        // so all of this is needed :)
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    //function withdraw() {}
}
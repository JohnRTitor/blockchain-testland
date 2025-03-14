// We need to
// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD
// We need to reduce gas cost

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";
error NotOwner();
error WithdrawFailed();

contract FundMe {
    // we need to specify this for it to work with uint256 objects
    using PriceConverter for uint256;
    // constant variables can not be changed once declared and assigned 
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // 21,415 gas - constant
    // 23,515 gas - non-constant

    address[] public funders;
    mapping(address =>  uint256) public addressToAmountFunded;

    // immutable variables are only allowed to change once, only in the constructor
    // can not be modified later
    address public immutable i_owner;
    // 21,508 gas - immutable
    // 23,644 gas - non-immutable

    constructor() {
        // Constructor gets immediately called after deploying a contract
        i_owner = msg.sender;
    }

    function fund() public payable  {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
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
        if (!callSuccess) { revert WithdrawFailed(); }
    }

    // this is custom modifier, it is executed first if added to a functon declaration
    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner!");
        if (msg.sender != i_owner) { revert NotOwner(); }
        _; // do the rest of the code
    }

    // What happens if someone sends us money without calling the fund() function
    // receive() or fallback() will be called, both will call fund() by itself
    // fund() can either then reject or accept the transaction depending on our minimum value logic
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}

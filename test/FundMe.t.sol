// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe private s_fundMe;
    address private immutable USER = makeAddr("user");
    uint256 private constant STARTING_BALANCE = 10 ether;
    uint256 private constant SEND_VALUE = 1 ether;

    modifier funded() {
        vm.prank(USER);
        s_fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        s_fundMe = deployFundMe.run();

        deal(USER, STARTING_BALANCE);
    }

    function test_MinimumDollarIsFive() public view {
        assertEq(s_fundMe.MINIMUM_USD(), 5e18);
    }

    function test_OwnerIsMsgSender() public view {
        assertEq(s_fundMe.i_owner(), msg.sender);
    }

    function test_PriceFeedVersionIsAccurate() public view {
        uint256 version = s_fundMe.getVersion();
        assertEq(version, 4);
    }

    function test_FundFailsWithoutEnoughtEth() public {
        vm.expectRevert();
        s_fundMe.fund();
    }

    function test_FundUpdatesFundDataStructure() public funded {
        uint256 amountFunded = s_fundMe.getAmountFundedByAddress(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function test_AddsFunderToArrayOfFunders() public funded {
        address funder = s_fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    function test_OnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        vm.prank(USER);
        s_fundMe.withdraw();
    }

    function test_WithdrawWithASingleFunder() public funded {
        // Arrange
        uint256 startingContractBalance = address(s_fundMe).balance;
        uint256 startingOwnerBalance = address(s_fundMe.getOwner()).balance;

        // Act
        vm.prank(s_fundMe.getOwner());
        s_fundMe.withdraw();

        // Assert
        uint256 endingContractBalance = address(s_fundMe).balance;
        uint256 endingOwnerBalance = address(s_fundMe.getOwner()).balance;
        assertEq(endingContractBalance, 0);
        assertEq(endingOwnerBalance, startingOwnerBalance + startingContractBalance);
    }

    function test_WithdrawFromMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i), SEND_VALUE); // prank + deal
            s_fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingContractBalance = address(s_fundMe).balance;
        uint256 startingOwnerBalance = address(s_fundMe.getOwner()).balance;

        // Act
        vm.prank(s_fundMe.getOwner());
        s_fundMe.withdraw();

        // Assert
        assertEq(address(s_fundMe).balance, 0);
        assertEq(address(s_fundMe.getOwner()).balance, startingOwnerBalance + startingContractBalance);
    }
}


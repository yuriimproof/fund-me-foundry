// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/InteractionFundMe.s.sol";

contract InteractionFundMeTest is Test {
    FundMe private s_fundMe;
    address private immutable USER = makeAddr("user");
    uint256 private constant SEND_VALUE = 1 ether;
    uint256 private constant STARTING_BALANCE = 10 ether;
    
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        s_fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function test_UserCanFundAndOwnerCanWithdraw() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(s_fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(s_fundMe));

        assertEq(address(s_fundMe).balance, 0);
    }
}




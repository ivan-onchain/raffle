// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract CreateSubscription is Script {
    constructor() {}

    function createSubscriptionUsingConfig() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();

        (, , address vrfCoordinator, , , ) = helperConfig.activeNetworkConfig();

        return createSubscription(vrfCoordinator);
    }

    function createSubscription(address vrfCoordinator) public returns (uint64){
        console.log("Creating subscription.");
        vm.startBroadcast();
        uint64 subId = VRFCoordinatorV2Mock(vrfCoordinator).createSubscription();
        vm.stopBroadcast();
        console.log("Your subscription is id is: ", subId);
        console.log("Please update subscription Id in HelperConfig.");
        return subId;
    }

    function run() external returns (uint64) {
        return createSubscriptionUsingConfig();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract CreateSubscription is Script {

    function createSubscriptionUsingConfig() public returns(uint64) {
        HelperConfig helperConfig = new HelperConfig();

        (,
        ,
        address vrfCoordinator,
        ,
        ,
        ) = helperConfig.activeNetwork();

        return createSubscription(vrfCoordinator);
    }

    function createSubscription(address vrfCoordinator) public returns(uint64) {
        console.log("Creating subscription on ChainId: ", block.chainid);
        vm.startBroadcast();

        vm.stopBroadcast();
    }

    function run() external returns(uint64) {
        return createSubscriptionUsingConfig();
    }
}
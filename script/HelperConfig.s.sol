// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {

    struct NetworkConfig {
        uint entranceFee; 
        uint interval; 
        address vrfCoordinator; 
        bytes32 gasLane; 
        uint64 subscriptionId;
        uint32 callbackGasLimit;
    }

}
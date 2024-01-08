// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";


/**
 * @title Smart contract lottery
 * @author Spencer Wilfahrt
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    
    error Raffle__NotEnoughEthSent();

    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    uint private immutable i_entranceFee;
    // @dev Duration of lottery in seconds
    
    address payable[] private s_players;
    uint private s_lastTimestamp;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint private immutable i_interval;
    uint32 private immutable i_callbackGasLimit;


    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(uint entranceFee, 
                uint interval, 
                VRFCoordinatorV2Interface vrfCoordinator, 
                bytes32 gasLane, 
                uint64 subscriptionId,
                uint32 callbackGasLimit
                ) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimestamp = block.timestamp;
        i_vrfCoordinator = vrfCoordinator;
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
        //whenever we make a storage update we should emit an event
    }

    // 1. Get random number
    // 2. Use random number to pick a player
    // 3. Be automatically called
    function pickWinner() public {
        //check to see if enough time has passed
        if ((block.timestamp - s_lastTimestamp) < i_interval) {
            revert();
        }
        uint requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
    }

    function fulfillRandomWords(uint requestId, uint[] memory randomWords) internal override {

    }

    /** Getter Functions */

    function getEntranceFee() external view returns(uint) {
        return i_entranceFee;
    }


}
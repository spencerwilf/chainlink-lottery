// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;


/**
 * @title Smart contract lottery
 * @author Spencer Wilfahrt
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    
    error Raffle__NotEnoughEthSent();

    uint private immutable i_entranceFee;
    // @dev Duration of lottery in seconds
    
    address payable[] private s_players;
    uint private s_lastTimestamp;
    address private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint private immutable i_interval;


    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(uint entranceFee, uint interval, address vrfCoordinator, bytes32 gasLane, uint64 subscriptionId) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimestamp = block.timestamp;
        i_vrfCoordinator = vrfCoordinator;
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
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
            
        )
    }

    /** Getter Functions */

    function getEntranceFee() external view returns(uint) {
        return i_entranceFee;
    }


}
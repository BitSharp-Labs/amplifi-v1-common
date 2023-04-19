// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for Treasurer
/// @notice Treasurer is responsible for maintaining statbility
interface ITreasurer {
    /// @notice Emitted when an underwater position was rescued
    /// @param positionId The position that was rescued
    /// @param writeOff The amount of PUD that was used for the rescue
    /// @param deficit The amount of PUD that was minted for the rescue
    event Rescue(address indexed positionId, uint256 writeOff, uint256 deficit);

    /// @notice Rescue an underwater position
    /// @dev MUST throw unless the position's equity ratio is 0 or less
    /// MUST emit Rescue
    /// @param positionId The position to rescue
    function rescue(uint256 positionId) external;
}

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

    /// @notice Get the appraisal of fungible tokens in PUD
    /// @param tokens The tokens to query
    /// @param amounts The amounts to query
    /// @return value The value of the tokens in PUD
    /// @return minEquity The minimum equity of the tokens in PUD
    function getFungibleTokensAppraisal(address[] calldata tokens, uint256[] calldata amounts)
        external
        view
        returns (uint256 value, uint256 minEquity);

    /// @notice Get the appraisal of non-fungible tokens in PUD
    /// @param tokens The tokens to query
    /// @param tokenIds The ids of the tokens
    /// @return value The value of the tokens in PUD
    /// @return minEquity The minimum equity of the tokens in PUD
    function getNonFungibleTokensAppraisal(address[] calldata tokens, uint256[] calldata tokenIds)
        external
        view
        returns (uint256 value, uint256 minEquity);
}

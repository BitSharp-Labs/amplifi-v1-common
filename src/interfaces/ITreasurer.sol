// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for Treasurer
/// @notice Treasurer is responsible for quoting prices and maintaining statbility
interface ITreasurer {
    /// @notice Emitted when an underwater position was rescued
    /// @param positionId The position that was rescued
    /// @param writeOff The amount of PUD that was spent during the rescue
    /// @param shortFall The amount of PUD that was minted during the rescue
    event Rescue(address indexed positionId, uint256 writeOff, uint256 shortFall);

    /// @notice Rescue an underwater position
    /// @dev MUST throw unless the position's equity is 0 or less
    /// MUST emit Rescue
    /// @param positionId The position to rescue
    function rescue(uint256 positionId) external;

    /// @notice Get the value and margin requirement of a fungible token in PUD
    /// @param token The token to query
    /// @param amount The amount to query
    /// @return value The value of the token in PUD
    /// @return margin The margin requirement of the token in PUD
    function getAppraisalOfFungible(address token, uint256 amount)
        external
        view
        returns (uint256 value, uint256 margin);

    /// @notice Get the value and margin requirement of fungible tokens in PUD
    /// @param tokens The tokens to query
    /// @param amounts The amounts to query
    /// @return value The value of the tokens in PUD
    /// @return margin The margin requirement of the tokens in PUD
    function getAppraisalOfFungibles(address[] calldata tokens, uint256[] calldata amounts)
        external
        view
        returns (uint256 value, uint256 margin);

    /// @notice Get the value and margin requirement of non-fungible tokens in PUD
    /// @param tokens The tokens to query
    /// @param items The items to query
    /// @return value The value of the tokens in PUD
    /// @return margin The margin requirement of the tokens in PUD
    function getAppraisalOfNonFungibles(address[] calldata tokens, uint256[] calldata items)
        external
        view
        returns (uint256 value, uint256 margin);

    /// @notice Get the underlying fungible tokens, values, and margin requirements in PUD of a non-fungible token
    /// @param token The token to query
    /// @param item The item to query
    /// @return tokens The underlying fungible tokens of the non-fungible token
    /// @return values The values of the underlying fungible tokens in PUD
    /// @return margins The margin requirements of the underlying fungible tokens in PUD
    function getAppraisalsOfNonFungible(address token, uint256 item)
        external
        view
        returns (address[] memory tokens, uint256[] memory values, uint256[] memory margins);
}

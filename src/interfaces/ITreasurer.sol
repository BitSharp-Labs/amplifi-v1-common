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

    /// @notice Get the value of a fungible token in PUD
    /// @param token The token to query
    /// @param amount The amount to query
    /// @return value The value of the token in PUD
    function getValueOfFungibleToken(address token, uint256 amount) external view returns (uint256 value);

    /// @notice Get the values of fungible tokens in PUD
    /// @param tokens The tokens to query
    /// @param amounts The amounts to query
    /// @return values The values of the tokens in PUD
    function getValuesOfFungibleTokens(address[] calldata tokens, uint256[] calldata amounts)
        external
        view
        returns (uint256[] memory values);

    /// @notice Get the underlying fungible tokens and values in PUD of a non-fungible token
    /// @param token The token to query
    /// @param tokenId The id of the token
    /// @return tokens The underlying fungible tokens of the non-fungible token
    /// @return values The values of the underlying fungible tokens in PUD
    function getValueOfNonFungibleToken(address token, uint256 tokenId)
        external
        view
        returns (address[] memory tokens, uint256[] memory values);
}

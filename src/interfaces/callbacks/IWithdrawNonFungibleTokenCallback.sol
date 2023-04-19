// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for callback during withdrawal of a fungible token
/// @notice Any contract that calls `IBookkeeper.withdrawNonFungibleToken()` must implement this interface
interface IWithdrawNonFungibleTokenCallback {
    /// @notice Called to `msg.sender` by `IBookkeeper.withdrawNonFungibleToken()` after withdrawal but before safety checks
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param tokenId The id of the token
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data passed by `msg.sender`
    function withdrawNonFungibleTokenCallback(
        uint256 positionId,
        address token,
        uint256 tokenId,
        address recipient,
        bytes calldata data
    ) external;
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for callback during withdrawal of a fungible token
/// @notice Any contract that calls `IBookkeeper.withdrawFungibleToken()` must implement this interface
interface IWithdrawFungibleTokenCallback {
    /// @notice Called to `msg.sender` by `IBookkeeper.withdrawFungibleToken()` after withdrawal but before safety checks
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param amount The amount to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data passed by `msg.sender`
    function withdrawFungibleTokenCallback(
        uint256 positionId,
        address token,
        uint256 amount,
        address recipient,
        bytes calldata data
    ) external;
}

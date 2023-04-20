// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for callback during withdrawal of fungible tokens
/// @notice Any contract that calls `IBookkeeper.withdrawFungibleTokens()` must implement this interface
interface IWithdrawFungibleTokensCallback {
    /// @notice Called to `msg.sender` by `IBookkeeper.withdrawFungibleTokens()` after withdrawal but before safety checks
    /// @param positionId The position to withdraw from
    /// @param tokens The tokens to withdraw
    /// @param amounts The amounts to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data passed by `msg.sender`
    function withdrawFungibleTokensCallback(
        uint256 positionId,
        address[] calldata tokens,
        uint256[] calldata amounts,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory result);
}

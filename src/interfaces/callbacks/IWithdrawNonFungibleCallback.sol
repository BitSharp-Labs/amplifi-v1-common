// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for callback during withdrawal of a non-fungible token
/// @notice Any contract that calls `IBookkeeper.withdrawNonFungible()` must implement this interface
interface IWithdrawNonFungibleCallback {
    /// @notice Called to `msg.sender` by `IBookkeeper.withdrawNonFungible()` after the withdrawal but before validations
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param item The item to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data passed by `msg.sender`
    function withdrawNonFungibleCallback(
        uint256 positionId,
        address token,
        uint256 item,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory result);
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for callback during borrowing of PUD
/// @notice Any contract that calls `IBookkeeper.borrow()` must implement this interface
interface IBorrowCallback {
    /// @notice Called to `msg.sender` by `IBookkeeper.borrow()` after borrowing but before safety checks
    /// @param positionId The position to borrow for
    /// @param amount The amount to borrow
    /// @param data Any data passed by `msg.sender`
    function borrowCallback(uint256 positionId, uint256 amount, bytes calldata data) external;
}

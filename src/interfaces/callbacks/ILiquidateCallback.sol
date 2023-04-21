// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Interface for callback during liquidation of a position
/// @notice Any contract that calls `IBookkeeper.liquidate()` must implement this interface
interface ILiquidateCallback {
    /// @notice Called to `msg.sender` by `IBookkeeper.liquidate()` after validations but before liquidation
    /// @param positionId The position to liquidate
    /// @param amount The amount of PUD needed for the liquidation
    /// @param data Any data passed by the `msg.sender`
    function liquidateCallback(uint256 positionId, uint256 amount, bytes calldata data) external;
}

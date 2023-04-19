// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/// @title Interface for PUD
/// @notice PUD (permissionless undercollateralized debt) is the endogenous debt token and the unit of account
interface IPUD is IERC20 {
    /// @notice Mint `amount` of PUD for `msg.sender`
    /// @dev MUST emit Transfer with `address(0)` as `from`
    /// @param amount The amount of PUD to be minted
    function mint(uint256 amount) external;

    /// @notice Burn `amount` of PUD for `msg.sender`
    /// @dev MUST throw unless `balanceOf(msg.sender) >= amount`
    /// MUST emit Transfer with `address(0)` as `to`
    /// @param amount The amount of PUD to be burned
    function burn(uint256 amount) external;
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../models/TokenInfo.sol";

/// @title Interface for Registrar
/// @notice Registrar is responsible for bootstrapping and managing global settings
interface IRegistrar {
    /// @notice Set the Bookkeeper associated with this Registrar, can only be set once
    /// @param bookkeeper The Bookkeeper
    function setBookkeeper(address bookkeeper) external;

    /// @notice Set the PUD associated with this Registrar, can only be set once
    /// @param pud The PUD
    function setPUD(address pud) external;

    /// @notice Set the Treasurer associated with this Registrar, can only be set once
    /// @param treasurer The Treasurer
    function setTreasurer(address treasurer) external;

    /// @notice Set the info for a token
    /// @param token The token to set
    /// @param tokenInfo The info of the token
    function setTokenInfo(address token, TokenInfo calldata tokenInfo) external;

    /// @notice Get the Bookkeeper associated with this Registrar
    /// @return bookkeeper The Bookkeeper
    function getBookkeeper() external view returns (address bookkeeper);

    /// @notice Get the PUD associated with this Registrar
    /// @return pud The PUD
    function getPUD() external view returns (address pud);

    /// @notice Get the Treasurer associated with this Registrar
    /// @return treasurer The Treasurer
    function getTreasurer() external view returns (address treasurer);

    /// @notice Get the info for a token
    /// @param token The token to query
    /// @return tokenInfo The info of the token
    function getTokenInfoOf(address token) external view returns (TokenInfo memory tokenInfo);
}

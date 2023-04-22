// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./TokenType.sol";
import "./TokenSubtype.sol";

/// @title Struct for token info
struct TokenInfo {
    TokenType type_;
    TokenSubtype subtype;
    bool enabled;
    address priceOracle;
    uint256 liquidationRatioUDx18;
}

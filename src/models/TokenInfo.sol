// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./TokenType.sol";
import "./TokenSubtype.sol";

struct TokenInfo {
    TokenType type_;
    TokenSubtype subtype;
    bool enabled;
    address priceOracle;
    uint256 marginRatioUDx18;
}

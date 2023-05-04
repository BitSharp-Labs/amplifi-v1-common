// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {RegressionMode} from "../models/RegressionMode.sol";
import {RepaymentMode} from "../models/RepaymentMode.sol";
import {TokenInfo} from "../models/TokenInfo.sol";

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

    /// @notice Set the base interest rate
    /// @param interestRateUDx18 The base interest rate with 18 decimals of precision
    function setInterestRate(uint256 interestRateUDx18) external;

    /// @notice Set the liquidation penalty rate
    /// @param penaltyRateUDx18 The liquidation penalty rate with 18 decimals of precision
    function setPenaltyRate(uint256 penaltyRateUDx18) external;

    /// @notice Set the interest allotment rates
    /// @param allotmentAddresses The addresses to allot to
    /// @param allotmentRatesUDx18 The rates of allotments with 18 decimals of precision
    function setAllotmentRates(address[] calldata allotmentAddresses, uint256[] calldata allotmentRatesUDx18)
        external;

    /// @notice Set the price regression mode
    /// @param regressionMode The price regression mode
    function setRegressionMode(RegressionMode regressionMode) external;

    /// @notice Set the repayment priority mode
    /// @param repaymentMode The repayment priority mode
    function setRepaymentMode(RepaymentMode repaymentMode) external;

    /// @notice Set the info of a token
    /// @param token The token to set for
    /// @param tokenInfo The info of the token
    function setTokenInfo(address token, TokenInfo calldata tokenInfo) external;

    /// @notice Get the PUD price peg associated with this Registrar
    /// @return pricePeg The PUD price peg
    function getPricePeg() external view returns (address pricePeg);

    /// @notice Get the Bookkeeper associated with this Registrar
    /// @return bookkeeper The Bookkeeper
    function getBookkeeper() external view returns (address bookkeeper);

    /// @notice Get the PUD associated with this Registrar
    /// @return pud The PUD
    function getPUD() external view returns (address pud);

    /// @notice Get the Treasurer associated with this Registrar
    /// @return treasurer The Treasurer
    function getTreasurer() external view returns (address treasurer);

    /// @notice Get the base interest rate
    /// @return interestRateUDx18 The base interest rate with 18 decimals of precision
    function getInterestRate() external view returns (uint256 interestRateUDx18);

    /// @notice Get the liquidation penalty rate
    /// @return penaltyRateUDx18 The liquidation penalty rate with 18 decimals of precision
    function getPenaltyRate() external view returns (uint256 penaltyRateUDx18);

    /// @notice Get the interest allotment rates
    /// @return allotmentAddresses The addresses to allot to
    /// @return allotmentRatesUDx18 The rates of allotments with 18 decimals of precision
    function getAllotmentRates()
        external
        view
        returns (address[] memory allotmentAddresses, uint256[] memory allotmentRatesUDx18);

    /// @notice Get the price regression mode
    /// @return regressionMode The price regression mode
    function getRegressionMode() external view returns (RegressionMode regressionMode);

    /// @notice Get the repayment priority mode
    /// @return repaymentMode The repayment priority mode
    function getRepaymentMode() external view returns (RepaymentMode repaymentMode);

    /// @notice Get the token infos
    /// @return tokens The tokens
    /// @return tokenInfos The token infos
    function getTokenInfos() external view returns (address[] memory tokens, TokenInfo[] memory tokenInfos);

    /// @notice Get the info of a token
    /// @param token The token to query
    /// @return tokenInfo The info of the token
    function getTokenInfoOf(address token) external view returns (TokenInfo memory tokenInfo);
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IERC721} from "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

/// @title Interface for Bookkeeper
/// @notice Bookkeeper is responsible for managing positions
interface IBookkeeper is IERC721, IERC721Receiver {
    /// @notice Emitted when a fungible token was deposited
    /// @param operator The operator of the deposit
    /// @param positionId The position that was deposited into
    /// @param token The token that was deposited
    /// @param amount The amount that was deposited
    event DepositFungibleToken(address indexed operator, uint256 indexed positionId, address token, uint256 amount);

    /// @notice Emitted when a non-fungible token was deposited
    /// @param operator The operator of the deposit
    /// @param positionId The position that was deposited into
    /// @param token The token that was deposited
    /// @param tokenId The id of the token
    event DepositNonFungibleToken(address indexed operator, uint256 indexed positionId, address token, uint256 tokenId);

    /// @notice Emitted when a fungible token was withdrawn
    /// @param operator The operator of the withdrawal
    /// @param positionId The position that was withdrawn from
    /// @param token The token that was withdrawn
    /// @param amount The amount that was withdrawn
    /// @param recipient The recipient of the withdrawal
    event WithdrawFungibleToken(
        address indexed operator, uint256 indexed positionId, address token, uint256 amount, address recipient
    );

    /// @notice Emitted when fungible tokens were withdrawn
    /// @param operator The operator of the withdrawal
    /// @param positionId The position that was withdrawn from
    /// @param tokens The tokens that were withdrawn
    /// @param amounts The amounts that were withdrawn
    /// @param recipient The recipient of the withdrawal
    event WithdrawFungibleTokens(
        address indexed operator, uint256 indexed positionId, address[] tokens, uint256[] amounts, address recipient
    );

    /// @notice Emitted when a non-fungible token was withdrawn
    /// @param operator The operator of the withdrawal
    /// @param positionId The position that was withdrawn from
    /// @param token The token that was withdrawn
    /// @param tokenId The id of the token
    /// @param recipient The recipient of the withdrawal
    event WithdrawNonFungibleToken(
        address indexed operator, uint256 indexed positionId, address token, uint256 tokenId, address recipient
    );

    /// @notice Deposit a fungible token into a position
    /// @dev The caller is responsible for the actual transfer prior to calling
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `token` is fungible and enabled
    /// MUST throw unless the amount received is greater than 0
    /// MUST emit DepositFungibleToken
    /// @param positionId The position to deposit into
    /// @param token The token to deposit
    /// @return amount The amount that was deposited
    function depositFungibleToken(uint256 positionId, address token) external returns (uint256 amount);

    /// @notice Deposit a non-fungible token into a position
    /// @dev The caller is responsible for the actual transfer prior to calling
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `token` is non-fungible and enabled
    /// MUST throw unless the specific token is received and not already deposited
    /// MUST emit DepositNonFungibleToken
    /// @param positionId The position to deposit into
    /// @param token The token to deposit
    /// @param tokenId The id of the token
    function depositNonFungibleToken(uint256 positionId, address token, uint256 tokenId) external;

    /// @notice Withdraw a fungible token from a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IWithdrawFungibleTokenCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the position has sufficient balance
    /// MUST throw unless equity ratio is at or above liquidation ratio
    /// MUST emit WithdrawFungibleToken
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param amount The amount to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data that should be passed to the callback
    function withdrawFungibleToken(
        uint256 positionId,
        address token,
        uint256 amount,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory callbackResult);

    /// @notice Withdraw fungible tokens from a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IWithdrawFungibleTokensCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST throw unless `tokens` and `amounts` are of equal length
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the position has sufficient balance for each token
    /// MUST throw unless equity ratio is at or above liquidation ratio
    /// MUST emit WithdrawFungibleTokens
    /// @param positionId The position to withdraw from
    /// @param tokens The tokens to withdraw
    /// @param amounts The amounts to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data that should be passed to the callback
    function withdrawFungibleTokens(
        uint256 positionId,
        address[] calldata tokens,
        uint256[] calldata amounts,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory callbackResult);

    /// @notice Withdraw an non-fungible token from a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IWithdrawNonFungibleTokenCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the specific token is in the position
    /// MUST throw unless equity ratio is at or above liquidation ratio
    /// MUST emit WithdrawNonFungibleToken
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param tokenId The id of the token
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data that should be passed to the callback
    function withdrawNonFungibleToken(
        uint256 positionId,
        address token,
        uint256 tokenId,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory callbackResult);
}

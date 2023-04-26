// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IERC721Enumerable} from "openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import {IERC721Receiver} from "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

/// @title Interface for Bookkeeper
/// @notice Bookkeeper is responsible for managing positions
interface IBookkeeper is IERC721Enumerable, IERC721Receiver {
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

    /// @notice Emitted when PUD is borrowed
    /// @param operator The operator of the borrowing
    /// @param positionId The position that is borrowed for
    /// @param amount The amount that is borrowed
    event Borrow(address indexed operator, uint256 indexed positionId, uint256 amount);

    /// @notice Emitted when PUD is repaid
    /// @param operator The operator of the repayment
    /// @param positionId The position that is repaid for
    /// @param principal The principal that is repaid
    /// @param interest The interest that is repaid
    event Repay(address indexed operator, uint256 indexed positionId, uint256 principal, uint256 interest);

    /// @notice Emitted when a position is liquidated
    /// @param operator The operator of the liquidation
    /// @param positionId The position that is liquidated
    /// @param recipient The recipient of the liquidation
    /// @param principal The principal that is repaid during the liquidation
    /// @param interest The interest that is repaid during the liquidation
    /// @param penalty The penalty that is paid during the liquidation
    /// @param equity The equity that is returned during the liquidation
    event Liquidate(
        address indexed operator,
        uint256 indexed positionId,
        address recipient,
        uint256 principal,
        uint256 interest,
        uint256 penalty,
        uint256 equity
    );

    /// @notice Mint a new position
    /// @dev MUST throw unless `msg.sender` is `recipient` or one of its operators
    /// MUST emit Transfer with `address(0)` as `from`
    /// @param originator The originator of the new position
    /// @param recipient The recipient of the new position
    /// @return positionId The id of the new position
    function mint(address originator, address recipient) external returns (uint256 positionId);

    /// @notice Burn a position
    /// @dev MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST throw unless the position has no outstanding asset or debt
    /// MUST emit Transfer with `address(0)` as `to`
    /// @param positionId The position to burn
    function burn(uint256 positionId) external;

    /// @notice Deposit a fungible token into a position
    /// @dev The `msg.sender` is responsible for transferring the fungible token before calling
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `token` is fungible and enabled
    /// MUST throw unless the amount received is greater than 0
    /// MUST emit DepositFungibleToken
    /// @param positionId The position to deposit into
    /// @param token The token to deposit
    /// @return amount The amount that was deposited
    function depositFungibleToken(uint256 positionId, address token) external returns (uint256 amount);

    /// @notice Deposit a non-fungible token into a position
    /// @dev The `msg.sender` is responsible for transferring the non-fungible token before calling
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
    /// MUST throw unless the position's equity is equal to or more than its margin requirement
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
    /// MUST throw unless the position's equity is equal to or more than its margin requirement
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
    /// MUST throw unless the position's equity is equal to or more than its margin requirement
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

    /// @notice Borrow PUD in a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IBorrowCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST throw unless the position's equity is equal to or more than its margin requirement
    /// MUST emit Borrow
    /// @param positionId The position to borrow for
    /// @param amount The amount to borrow
    /// @param data Any data that should be passed to the callback
    function borrow(uint256 positionId, uint256 amount, bytes calldata data) external;

    /// @notice Repay PUD in a position
    /// @dev Sufficient PUD must already exist in the position, call `depositFungibleToken()` first if needed
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST throw unless the position has sufficient PUD
    /// MUST emit Repay
    /// @param positionId The position to repay for
    /// @param amount The amount to repay
    function repay(uint256 positionId, uint256 amount) external;

    /// @notice Liquidate a position
    /// @dev If `msg.sender` is a contract then it MUST implement `ILiquidateCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the position's equity is below its margin requirement before callback
    /// MUST throw unless there is sufficient PUD to cover all of principal, interest, and returning equity after callback
    /// MUST emit Liquidate
    /// @param positionId The position to liquidate
    /// @param recipient The recipient of the liquidation
    /// @param data Any data that should be passed to the callback
    function liquidate(uint256 positionId, address recipient, bytes calldata data) external;

    /// @notice Get the total debt of all positions in PUD
    /// @return totalDebt The total debt in PUD
    function getTotalDebt() external view returns (uint256 totalDebt);

    /// @notice Get the debt of a position in PUD
    /// @param positionId The position to query
    /// @return debt The debt in PUD
    function getDebtOf(uint256 positionId) external view returns (uint256 debt);

    /// @notice Get the value and margin requirement of a position in PUD
    /// @param positionId The position to query
    /// @return value The value in PUD
    /// @return margin The margin requirement in PUD
    function getAppraisalOf(uint256 positionId) external view returns (uint256 value, uint256 margin);

    /// @notice Get the fungible tokens and respective balances in a position
    /// @param positionId The position to query
    /// @return tokens The fungible tokens
    /// @return balances The balances
    function getFungibleTokensOf(uint256 positionId)
        external
        view
        returns (address[] memory tokens, uint256[] memory balances);

    /// @notice get the non-fungible tokens and respective token IDs in a position
    /// @param positionId The position to query
    /// @return tokens The non-fungible tokens
    /// @return tokenIds The token IDs
    function getNonFungibleTokensOf(uint256 positionId)
        external
        view
        returns (address[] memory tokens, uint256[] memory tokenIds);
}

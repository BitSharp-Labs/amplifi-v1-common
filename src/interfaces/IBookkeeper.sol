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
    event DepositFungible(address indexed operator, uint256 indexed positionId, address token, uint256 amount);

    /// @notice Emitted when a non-fungible token was deposited
    /// @param operator The operator of the deposit
    /// @param positionId The position that was deposited into
    /// @param token The token that was deposited
    /// @param tokenId The specific item that was deposited
    event DepositNonFungible(address indexed operator, uint256 indexed positionId, address token, uint256 tokenId);

    /// @notice Emitted when a fungible token was withdrawn
    /// @param operator The operator of the withdrawal
    /// @param positionId The position that was withdrawn from
    /// @param token The token that was withdrawn
    /// @param amount The amount that was withdrawn
    /// @param recipient The recipient of the withdrawal
    event WithdrawFungible(
        address indexed operator, uint256 indexed positionId, address token, uint256 amount, address recipient
    );

    /// @notice Emitted when fungible tokens were withdrawn
    /// @param operator The operator of the withdrawal
    /// @param positionId The position that was withdrawn from
    /// @param tokens The tokens that were withdrawn
    /// @param amounts The amounts that were withdrawn
    /// @param recipient The recipient of the withdrawal
    event WithdrawFungibles(
        address indexed operator, uint256 indexed positionId, address[] tokens, uint256[] amounts, address recipient
    );

    /// @notice Emitted when a non-fungible token was withdrawn
    /// @param operator The operator of the withdrawal
    /// @param positionId The position that was withdrawn from
    /// @param token The token that was withdrawn
    /// @param tokenId The specific item that was withdrawn
    /// @param recipient The recipient of the withdrawal
    event WithdrawNonFungible(
        address indexed operator, uint256 indexed positionId, address token, uint256 tokenId, address recipient
    );

    /// @notice Emitted when PUD was borrowed
    /// @param operator The operator of the borrowing
    /// @param positionId The position that was borrowed for
    /// @param amount The amount that was borrowed
    event Borrow(address indexed operator, uint256 indexed positionId, uint256 amount);

    /// @notice Emitted when PUD was repaid
    /// @param operator The operator of the repayment
    /// @param positionId The position that was repaid for
    /// @param principal The principal that was repaid
    /// @param interest The interest that was repaid
    event Repay(address indexed operator, uint256 indexed positionId, uint256 principal, uint256 interest);

    /// @notice Emitted when a position was liquidated
    /// @param operator The operator of the liquidation
    /// @param positionId The position that was liquidated
    /// @param principal The principal that was repaid during the liquidation
    /// @param interest The interest that was repaid during the liquidation
    /// @param penalty The penalty that was charged during the liquidation
    /// @param equity The equity that was returned during the liquidation
    /// @param recipient The recipient of the liquidation
    event Liquidate(
        address indexed operator,
        uint256 indexed positionId,
        uint256 principal,
        uint256 interest,
        uint256 penalty,
        uint256 equity,
        address recipient
    );

    /// @notice Mint a new position
    /// @dev MUST throw unless `msg.sender` is `recipient` or one of its operators
    /// MUST emit Transfer with `address(0)` as `from`
    /// @param originator The originator of the position
    /// @param recipient The recipient of the position
    /// @return positionId The minted position
    function mint(address originator, address recipient) external returns (uint256 positionId);

    /// @notice Burn a position
    /// @dev MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the owner or one of its operators
    /// MUST throw unless the position has no outstanding assets or debts
    /// MUST emit Transfer with `address(0)` as `to`
    /// @param positionId The position to burn
    function burn(uint256 positionId) external;

    /// @notice Deposit a fungible token into a position
    /// @dev The `msg.sender` is responsible for transferring the fungible token before calling
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `token` is fungible and enabled
    /// MUST throw unless the amount received is greater than 0
    /// MUST emit DepositFungible
    /// @param positionId The position to deposit into
    /// @param token The token to deposit
    /// @return amount The amount that was deposited
    function depositFungible(uint256 positionId, address token) external returns (uint256 amount);

    /// @notice Deposit a non-fungible token into a position
    /// @dev The `msg.sender` is responsible for transferring the non-fungible token before calling
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `token` is non-fungible and enabled
    /// MUST throw unless the specific item is received and not already in a position
    /// MUST emit DepositNonFungible
    /// @param positionId The position to deposit into
    /// @param token The token to deposit
    /// @param tokenId The specific item to deposit
    function depositNonFungible(uint256 positionId, address token, uint256 tokenId) external;

    /// @notice Withdraw a fungible token from a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IWithdrawFungibleCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the owner or one of its operators
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the position has sufficient balance before the withdrawal
    /// MUST throw unless the position has sufficient equity after the withdrawal
    /// MUST emit WithdrawFungible
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param amount The amount to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data that should be passed through to `IWithdrawFungibleCallback.withdrawFungibleCallback()`
    /// @return callbackResult The result of the callback
    function withdrawFungible(uint256 positionId, address token, uint256 amount, address recipient, bytes calldata data)
        external
        returns (bytes memory callbackResult);

    /// @notice Withdraw fungible tokens from a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IWithdrawFungiblesCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the owner or one of its operators
    /// MUST throw unless `tokens` and `amounts` have the same length
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the position has sufficient balance for each token before the withdrawal
    /// MUST throw unless the position has sufficient equity after the withdrawal
    /// MUST emit WithdrawFungibles
    /// @param positionId The position to withdraw from
    /// @param tokens The tokens to withdraw
    /// @param amounts The amounts to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data that should be passed through to `IWithdrawFungiblesCallback.withdrawFungiblesCallback()`
    /// @return callbackResult The result of the callback
    function withdrawFungibles(
        uint256 positionId,
        address[] calldata tokens,
        uint256[] calldata amounts,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory callbackResult);

    /// @notice Withdraw a non-fungible token from a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IWithdrawNonFungibleCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the owner or one of its operators
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the specific item is in the position before the withdrawal
    /// MUST throw unless the position has sufficient equity after the withdrawal
    /// MUST emit WithdrawNonFungible
    /// @param positionId The position to withdraw from
    /// @param token The token to withdraw
    /// @param tokenId The specific item to withdraw
    /// @param recipient The recipient of the withdrawal
    /// @param data Any data that should be passed through to `IWithdrawNonFungibleCallback.withdrawNonFungibleCallback()`
    /// @return callbackResult The result of the callback
    function withdrawNonFungible(
        uint256 positionId,
        address token,
        uint256 tokenId,
        address recipient,
        bytes calldata data
    ) external returns (bytes memory callbackResult);

    /// @notice Borrow PUD in a position
    /// @dev If `msg.sender` is a contract then it MUST implement `IBorrowCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the owner or one of its operators
    /// MUST throw unless the position has sufficient equity after the borrowing
    /// MUST emit Borrow
    /// @param positionId The position to borrow for
    /// @param amount The amount to borrow
    /// @param data Any data that should be passed through to `IBorrowCallback.borrowCallback()`
    function borrow(uint256 positionId, uint256 amount, bytes calldata data) external;

    /// @notice Repay PUD in a position
    /// @dev The position MUST have sufficient PUD already, call `depositFungible()` first if needed
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `msg.sender` is the position owner or one of its operators
    /// MUST emit Repay
    /// @param positionId The position to repay for
    /// @param amount The amount to repay
    function repay(uint256 positionId, uint256 amount) external;

    /// @notice Liquidate a position
    /// @dev If `msg.sender` is a contract then it MUST implement `ILiquidateCallback`
    /// MUST throw unless `positionId` exists
    /// MUST throw unless `recipient` is not the zero address
    /// MUST throw unless the position has insufficient equity before the liquidation
    /// MUST throw unless the position has sufficient PUD to cover principal (and any interest and remaining equity, net penalty) after the callback
    /// MUST emit Liquidate
    /// @param positionId The position to liquidate
    /// @param recipient The recipient of the liquidation
    /// @param data Any data that should be passed through to `ILiquidateCallback.liquidateCallback()`
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

    /// @notice Get the fungible tokens and balances of a position
    /// @param positionId The position to query
    /// @return tokens The fungible tokens
    /// @return balances The balances
    function getFungiblesOf(uint256 positionId)
        external
        view
        returns (address[] memory tokens, uint256[] memory balances);

    /// @notice Get the non-fungible tokens and specific items of a position
    /// @param positionId The position to query
    /// @return tokens The non-fungible tokens
    /// @return tokenIds The specific items
    function getNonFungiblesOf(uint256 positionId)
        external
        view
        returns (address[] memory tokens, uint256[] memory tokenIds);
}

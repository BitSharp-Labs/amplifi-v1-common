// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Context} from "openzeppelin-contracts/contracts/utils/Context.sol";

contract Addressable is Context {
    modifier requireSender(address address_) {
        require(address_ == _msgSender(), "Addressable: require sender");
        _;
    }

    modifier requireZeroAddress(address address_) {
        require(address_ == address(0), "Addressable: require zero address");
        _;
    }

    modifier requireNonZeroAddress(address address_) {
        require(address_ != address(0), "Addressable: require non-zero address");
        _;
    }
}

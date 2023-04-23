// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Lockable {
    bool private s_unlocked;

    modifier lock() {
        require(s_unlocked, "Lockable: locked");
        s_unlocked = false;
        _;
        s_unlocked = true;
    }

    function initLock() internal {
        s_unlocked = true;
    }
}

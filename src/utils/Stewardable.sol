// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Stewardable {
    address private s_steward;
    address private s_successor;

    modifier requireSteward() {
        require(msg.sender == s_steward, "Stewardable: require steward");
        _;
    }

    modifier requireSuccessor() {
        require(msg.sender == s_successor, "Stewardable: require successor");
        _;
    }

    constructor(address steward) {
        s_steward = steward;
    }

    function succeedSteward() external requireSuccessor {
        s_steward = s_successor;
        s_successor = address(0);
    }

    function appointSuccessor(address successor) external requireSteward {
        s_successor = successor;
    }
}

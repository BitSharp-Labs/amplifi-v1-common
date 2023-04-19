// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library ArrayHelper {
    function remove(address[] storage s_self, address item) internal {
        uint256 length = s_self.length;
        for (uint256 i = 0; i < length; i++) {
            if (s_self[i] == item) {
                if (i != length - 1) {
                    s_self[i] = s_self[length - 1];
                }
                s_self.pop();
                break;
            }
        }

        require(s_self.length == length - 1, "ArrayHelper: item not in array");
    }

    function remove(uint256[] storage s_self, uint256 item) internal {
        uint256 length = s_self.length;
        for (uint256 i = 0; i < length; i++) {
            if (s_self[i] == item) {
                if (i != length - 1) {
                    s_self[i] = s_self[length - 1];
                }
                s_self.pop();
                break;
            }
        }

        require(s_self.length == length - 1, "ArrayHelper: item not in array");
    }
}

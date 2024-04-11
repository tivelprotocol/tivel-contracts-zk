// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.4;

/// @title Provides functions for deriving a pool address from the pool deployer, tokens
library PoolAddress {
    bytes32 internal constant POOL_INIT_CODE_HASH =
        0x010012d58a0d277fd0a7bc37e2d0450edba3621cf86ae8f5b05153f415949bfc;
    bytes32 internal constant CREATE2_PREFIX = keccak256("zksyncCreate2");
    bytes32 internal constant EMPTY_CONSTRUCTOR_INPUT = keccak256("");

    function computeAddress(
        address _poolDeployer,
        address _token
    ) internal pure returns (address pool) {
        bytes32 senderBytes = bytes32(uint256(uint160(_poolDeployer)));
        bytes32 data = keccak256(
            abi.encodePacked(
                CREATE2_PREFIX,
                senderBytes,
                keccak256(abi.encode(_token)),
                POOL_INIT_CODE_HASH,
                EMPTY_CONSTRUCTOR_INPUT
            )
        );

        pool = address(uint160(uint256(data)));
    }
}

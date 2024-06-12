// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.4;

/// @title Provides functions for deriving a pool address from the pool deployer, tokens
library PoolAddress {
    bytes32 internal constant POOL_INIT_CODE_HASH =
        0x01000c115a29a74b442ddba1494a2d0091c1cf17569c5074a801c151a19983ba;
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


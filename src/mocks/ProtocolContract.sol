// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../ProtocolContract.sol";

contract MockProtocolContract is ProtocolContract {
    address private mockOwner;

    constructor(address _vaultFactory, address _mockOwner) ProtocolContract(_vaultFactory) {
        mockOwner = _mockOwner;
    }

    function owner() public view override returns (address) {
        return mockOwner;
    }
}

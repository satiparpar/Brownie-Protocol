// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../ProtocolContract.sol";
import "../StakingToken.sol";

contract MockRewardVault is IBerachainRewardsVault {
    mapping(address => uint256) public balances;
    address public operator;

    function delegateStake(address user, uint256 amount) external override {
        balances[user] += amount;
    }

    function delegateWithdraw(address user, uint256 amount) external override {
        require(balances[user] >= amount, "Insufficient balance");
        balances[user] -= amount;
    }

    function getReward(address user) external override returns (uint256) {
        require(balances[user] > 0, "No reward");
        return balances[user];
    }

    function setOperator(address _operator) external override {
        operator = _operator;
    }

    function balanceOf(address user) external view override returns (uint256) {
        return balances[user];
    }

    function getTotalDelegateStaked(address user) external view override returns (uint256) {
        return balances[user];
    }
}

contract MockRewardVaultFactory is IBerachainRewardsVaultFactory {
    address public vaultAddress;

    constructor(address _vaultAddress) {
        vaultAddress = _vaultAddress;
    }

    function createRewardsVault(address) external override returns (address) {
        return vaultAddress;
    }
}

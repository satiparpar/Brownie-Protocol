// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IBerachainRewardsVault {
    function delegateStake(address account, uint256 amount) external;

    function delegateWithdraw(address account, uint256 amount) external;

    function getTotalDelegateStaked(
        address account
    ) external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function getReward(address account) external returns (uint256);

    function setOperator(address _operator) external;
}

interface IBerachainRewardsVaultFactory {
    function createRewardsVault(
        address stakingToken
    ) external returns (address);
}

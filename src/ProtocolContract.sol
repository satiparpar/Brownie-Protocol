// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./StakingToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {IBerachainRewardsVault, IBerachainRewardsVaultFactory} from "./interfaces/IRewardVaults.sol";

contract ProtocolContract is Ownable {
    StakingToken public stakingToken;
    IBerachainRewardsVault public rewardVault;

    mapping(address => uint256) public userActivity;

    constructor(address _vaultFactory) Ownable(msg.sender) {
        stakingToken = new StakingToken();

        address vaultAddress = IBerachainRewardsVaultFactory(_vaultFactory)
            .createRewardsVault(address(stakingToken));

        rewardVault = IBerachainRewardsVault(vaultAddress);
    }

    function addActivity(address user, uint256 amount) external onlyOwner {
        userActivity[user] += amount;
        stakingToken.mint(address(this), amount);
        stakingToken.approve(address(rewardVault), amount);
        rewardVault.delegateStake(user, amount);
    }

    function removeActivity(address user, uint256 amount) external onlyOwner {
        require(userActivity[user] >= amount, "Insufficient user activity");
        userActivity[user] -= amount;
        rewardVault.delegateWithdraw(user, amount);
        stakingToken.burn(address(this), amount);
    }

    function getReward(address user) external {
        require(userActivity[user] > 0, "No activity for user");
        rewardVault.getReward(user);
    }

    function getBalance(address _address) external view returns (uint256) {
        return rewardVault.balanceOf(_address);
    }
}

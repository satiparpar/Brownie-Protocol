// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./StakingToken.sol";
import {IBerachainRewardsVault, IBerachainRewardsVaultFactory} from "./interfaces/IRewardVaults.sol";

contract ProtocolContract {
    StakingToken public stakingToken;
    IBerachainRewardsVault public rewardVault;

    mapping(address => uint256) public userActivity;
    address[] public userAddresses;

    constructor(address _vaultFactory) {
        stakingToken = new StakingToken();
        address vaultAddress = IBerachainRewardsVaultFactory(_vaultFactory)
            .createRewardsVault(address(stakingToken));

        rewardVault = IBerachainRewardsVault(vaultAddress);
    }

    fallback() external payable {
        gauging(msg.value);
    }

    receive() external payable {
        gauging(msg.value);
    }

    function gauging(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        uint256 perToken = amount / stakingToken.totalSupply();
        for (uint256 i = 0; i < userAddresses.length; i++) {
            address user = userAddresses[i];
            uint256 perUser = userActivity[user] * perToken;
            if (perUser == 0) {
                break;
            }
            payable(address(user)).transfer(perUser);
        }
    }

    function addActivity(address user, uint256 amount) external {
        userActivity[user] += amount;
        userAddresses.push(user);

        stakingToken.mint(address(this), amount);

        stakingToken.approve(address(rewardVault), amount);
        rewardVault.delegateStake(user, amount);
    }

    function removeAddressFromList(address user) internal {
        for (uint256 i = 0; i < userAddresses.length; i++) {
            if (userAddresses[i] == user) {
                userAddresses[i] = userAddresses[userAddresses.length - 1];
                userAddresses.pop();
                break;
            }
        }
    }

    function removeActivity(address user, uint256 amount) external {
        require(userActivity[user] >= amount, "Insufficient user activity");
        userActivity[user] -= amount;
        if (userActivity[user] == 0) {
            removeAddressFromList(user);
        }
        rewardVault.delegateWithdraw(user, amount);

        stakingToken.burn(address(this), amount);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/mocks/Interfaces.sol";
import "../src/mocks/ProtocolContract.sol";

contract ProtocolContractTest is Test {
    MockProtocolContract public protocolContract;
    StakingToken public stakingToken;
    MockRewardVault public mockRewardVault;
    MockRewardVaultFactory public mockRewardVaultFactory;
    address public owner;
    address public user;
    address public operator;

    function setUp() public {
        owner = address(this);
        user = address(0x1);
        operator = address(0x2);

        mockRewardVault = new MockRewardVault();
        mockRewardVaultFactory = new MockRewardVaultFactory(address(mockRewardVault));

        protocolContract = new MockProtocolContract(address(mockRewardVaultFactory), owner);
        stakingToken = StakingToken(protocolContract.stakingToken());
    }

    function testDeployment() public view {
        assertEq(protocolContract.owner(), owner, "Owner should be correctly set");
        assertEq(
            address(protocolContract.rewardVault()), address(mockRewardVault), "RewardVault should be correctly set"
        );
        assertEq(
            address(protocolContract.stakingToken()), address(stakingToken), "StakingToken should be correctly set"
        );
    }

    function testAddActivity() public {
        uint256 amount = 100 ether;

        protocolContract.addActivity(user, amount);

        assertEq(protocolContract.userActivity(user), amount, "User activity should be updated");
        assertEq(stakingToken.balanceOf(address(protocolContract)), amount, "Contract should hold the minted tokens");
        assertEq(
            stakingToken.allowance(address(protocolContract), address(mockRewardVault)),
            amount,
            "Token allowance should be set"
        );
        assertEq(mockRewardVault.balanceOf(user), amount, "Vault should have delegated stake for user");
    }

    function testRemoveActivity() public {
        uint256 amount = 100 ether;

        protocolContract.addActivity(user, amount);

        uint256 removeAmount = 50 ether;
        protocolContract.removeActivity(user, removeAmount);

        assertEq(protocolContract.userActivity(user), amount - removeAmount, "User activity should be decreased");
        assertEq(mockRewardVault.balanceOf(user), amount - removeAmount, "Vault should have decreased delegated stake");
        assertEq(
            stakingToken.balanceOf(address(protocolContract)),
            amount - removeAmount,
            "Contract should hold fewer tokens"
        );
    }

    function testRemoveActivityInsufficientBalance() public {
        uint256 amount = 100 ether;
        protocolContract.addActivity(user, amount);

        vm.expectRevert("Insufficient user activity");
        protocolContract.removeActivity(user, amount + 1);
    }

    function testGetReward() public {
        uint256 amount = 100 ether;

        protocolContract.addActivity(user, amount);

        protocolContract.getReward(user);
    }

    function testGetRewardNoActivity() public {
        vm.expectRevert("No activity for user");
        protocolContract.getReward(user);
    }

    function testSetOperator() public {
        protocolContract.setOperator(operator);
        assertEq(mockRewardVault.operator(), operator, "Operator should be set correctly in vault");
    }

    function testGetBalance() public {
        uint256 amount = 100 ether;
        protocolContract.addActivity(user, amount);

        assertEq(protocolContract.getBalance(user), amount, "getBalance should return correct balance");
    }

    function testOnlyOwnerCanAddActivity() public {
        uint256 amount = 100 ether;

        vm.prank(user);
        vm.expectRevert();
        protocolContract.addActivity(user, amount);
    }

    function testOnlyOwnerCanRemoveActivity() public {
        uint256 amount = 100 ether;
        protocolContract.addActivity(user, amount);

        vm.prank(user);
        vm.expectRevert();
        protocolContract.removeActivity(user, amount);
    }
}

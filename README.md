
# Proof of Liquidity Integration Guide for Non-ERC20 Protocols on Berachain

This repository contains the ProtocolContract, a smart contract designed to integrate Berachain's Proof of Liquidity (PoL) system for protocols that do not naturally produce ERC20 receipt tokens.

## Overview
The Proof of Liquidity Integration Guide for Non-ERC20 Protocols explains how to incorporate Berachain's PoL system for protocols that do not produce ERC20 receipt tokens. It details a method where a dummy StakingToken is created to track user balances, allowing protocols like perpetual futures exchanges to reward users with $BERA for opening positions. This approach involves minting and burning the dummy token through the ProtocolContract, enabling participation in PoL and enhancing incentive efficiencies. Note that this is one of several potential solutions for integrating PoL.

## Key functions of the contract:

**Staking and Rewards** : The contract mints dummy Staking Tokens representing user activity, allowing them to earn rewards via Berachain's PoL vaults.
**Reward Distribution** : Users earn rewards based on their staked balance when liquidity is provided or removed.
**Activity Tracking** : Internal tracking of user activity is managed through mappings and a list of user addresses.

## Features

**Delegate Stake** : Users can delegate their stake to earn rewards in the PoL vault through addActivity().
**Withdraw Rewards**: Users can remove liquidity via removeActivity(), burning the dummy tokens and ceasing reward accrual.
**Automatic Payouts**: The contract distributes rewards automatically via fallback and receive functions when users provide liquidity.


## Installation

Clone the repository.
Compile and deploy the contract using Solidity ^0.8.19.
Integrate with the Berachain Proof of Liquidity Vault.

## License
This project is licensed under the MIT License.

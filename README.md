
### ProtocolContract - Proof of Liquidity Integration

This repository contains the ProtocolContract, a smart contract designed to integrate Berachain's Proof of Liquidity (PoL) system for protocols that do not naturally produce ERC20 receipt tokens.

## Overview
The ProtocolContract allows users to earn $BGT rewards by staking a dummy token (StakingToken). This approach is beneficial for protocols that need to track user activity internally and cannot directly mint ERC20 receipt tokens.


## Key functions of the contract:

**Staking and Rewards** : The contract mints dummy StakingTokens representing user activity, allowing them to earn rewards via Berachain's PoL vaults.
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

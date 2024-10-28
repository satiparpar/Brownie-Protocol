
# Brownie Protocol
This repository contains a protocol written in Solidity for calculating and managing user activity based on their interactions with LP protocols like BEND and AAVE. This protocol assesses user activity based on their deposits across these platforms and rewards them accordingly.

## Overview
This project aims to provide an incentive mechanism where users are scored based on their active contributions. Users receive "positive" or "negative" points based on their deposits in various LP protocols, which influence their rewards within this protocol.

## Core Features:
Activity Scoring: Calculates user activity based on deposits in BEND and AAVE.

BEND Deposits: Users gain positive points, increasing their activity score.

AAVE Deposits: Users incur negative points, reducing their activity score.

Reward Distribution: Users earn BGT from the protocol's reward vault based on their activity.

##  Deploying ProtocolContract
To deploy the ProtocolContract on the Berachain network, use the following forge create command. Make sure you have Foundry installed and configured.

Prerequisites
Ensure you have the Berachain RPC URL: https://bartio.rpc.berachain.com/.

Set your private key in the WALLET_PRIVATE_KEY environment variable. You can export it in your shell for convenience:

```bash
export WALLET_PRIVATE_KEY=your_private_key_here
```

## Deployment Command
Run the following command to deploy the contract:

```bash
forge create --rpc-url https://bartio.rpc.berachain.com/ --private-key $WALLET_PRIVATE_KEY src/ProtocolContract.sol:ProtocolContract --constructor-args 0x2B6e40f65D82A0cB98795bC7587a71bfa49fBB2B
```

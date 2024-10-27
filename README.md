
# Non-ERC20 Activity & Reward Protocol on Berachain
This repository contains a protocol written in Solidity for calculating and managing user activity based on their interactions with LP protocols like BEND and AAVE. This protocol assesses user activity based on their deposits across these platforms and rewards them accordingly.

## Overview
This project aims to provide an incentive mechanism where users are scored based on their active contributions. Users receive "positive" or "negative" points based on their deposits in various LP protocols, which influence their rewards within this protocol.

## Core Features:

Activity Scoring: Calculates user activity based on deposits in BEND and AAVE.

BEND Deposits: Users gain positive points, increasing their activity score.

AAVE Deposits: Users incur negative points, reducing their activity score.

Reward Distribution: Users earn BGT from the protocol's reward vault based on their activity amount.
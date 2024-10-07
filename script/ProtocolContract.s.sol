// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import "../src/ProtocolContract.sol";

contract ProtocolContractScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("WALLET_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        new ProtocolContract(0x2B6e40f65D82A0cB98795bC7587a71bfa49fBB2B);
        vm.stopBroadcast();
    }
}

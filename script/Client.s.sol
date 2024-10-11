// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Client} from "../src/Client.sol";

contract RouterScript is Script {
    Client public client;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        client = new Client();

        vm.stopBroadcast();
    }
}

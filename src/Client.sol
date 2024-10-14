pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {ClientBase} from "@cambrian/contracts/ClientBase.sol";
import {Cambrian} from "@cambrian/contracts/Cambrian.sol";
import {IClient} from "@cambrian/contracts/IClient.sol";
import {CambrianRouter} from "@cambrian/contracts/CambrianRouter.sol";

contract Client is ClientBase, Ownable, IClient {
    using Cambrian for Cambrian.Query;

    mapping(bytes32 => uint8) messages;

    __EVENT_STRUCTURE__

    constructor()
        Ownable(msg.sender)
        ClientBase(
            CambrianRouter("__CAMBRIAN_ROUTER__"),
            __CAMBRIAN_QUERY__
        )
    {}

    function executeQuery() external onlyOwner returns (bytes32) {
        bytes32 messageId = execute();
        messages[messageId] = 0;
        return messageId;
    }

    function handleSuccess(
        bytes32 messageId,
        Cambrian.Event[] memory events,
        Report calldata report
    ) external override {
        // to be overrided by custom app
        // handle events
    }

    function handleStatus(
        bytes32 messageId,
        Report calldata report
    ) external override {
        // to be overrided by custom app
        // handle errors also
    }
}

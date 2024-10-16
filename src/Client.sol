pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {ClientBase} from "@cambrian/contracts/ClientBase.sol";
import {CambrianQuery,CambrianEvent, Report} from "@cambrian/contracts/Cambrian.sol";
import {IClient} from "@cambrian/contracts/IClient.sol";
import {CambrianRouter} from "@cambrian/contracts/CambrianRouter.sol";

contract Client is ClientBase, Ownable, IClient {
    mapping(bytes32 => uint8) messages;

    __EVENT_STRUCTURE__

    constructor()
        Ownable(msg.sender)
        ClientBase(
            CambrianRouter(__CAMBRIAN_ROUTER__),
            __CAMBRIAN_QUERY__
        )
    {}

    function executeQuery(uint64 startBlock, uint64 endBlock) external onlyOwner returns (bytes32) {
        bytes32 messageId = execute(startBlock, endBlock);
        messages[messageId] = 0;
        return messageId;
    }

    function handleSuccess(
        bytes32 messageId,
        CambrianEvent[] memory events,
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

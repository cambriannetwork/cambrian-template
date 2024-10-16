pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {ClientBase} from "@cambrian/contracts/ClientBase.sol";
import {IClient,Response,Status} from "@cambrian/contracts/Cambrian.sol";
import {CambrianRouter} from "@cambrian/contracts/CambrianRouter.sol";

contract Client is ClientBase, Ownable, IClient {
    mapping(uint256 => uint8) messages;

    __EVENT_STRUCTURE__

    constructor()
        Ownable(msg.sender)
        ClientBase(
            CambrianRouter(__CAMBRIAN_ROUTER__),
            __CAMBRIAN_QUERY__
        )
    {}

    function executeQuery(uint64 startBlock, uint64 endBlock) external onlyOwner returns (uint256) {
        uint256 messageId = execute(startBlock, endBlock);
        messages[messageId] = 0;
        return messageId;
    }

    function handleSuccess(
        Response memory response
    ) external override {
        for (uint32 i = 0; i < response.events.length; i++) {
            __EVENT_NAME__ memory swap = abi.decode(response.events[i].data, (__EVENT_NAME__));
            // to be overrided by custom app
            // handle events
        }
    }

    function handleStatus(
        Status calldata status
    ) external override {

        messages[status.messageId] = status.code;

        // to be overrided by custom app
        // handle errors also
    }
}

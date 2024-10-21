pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {ClientBase} from "@cambrian/contracts/ClientBase.sol";
import {IClient,Log} from "@cambrian/contracts/Cambrian.sol";
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

    function handleSuccess(uint256 messageId, bytes memory data, Log[] calldata logs) external override {
        __EVENT_NAME__[] memory sdata = abi.decode(data, (__EVENT_NAME__[]));
        handleData(sdata, logs);
    }

    function handleData(__EVENT_NAME__[] memory data, Log[] calldata logs) public {
        // to be overrided by custom app
        // handle data
    }

    function handleStatus(uint256 messageId, uint8 status, string calldata message) external override {
        // to be overrided by custom app
        // handle status
    }
}

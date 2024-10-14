pragma solidity ^0.8.20;

import {Cambrian} from "./Cambrian.sol";

contract CambrianRouter {
    using Cambrian for Cambrian.Query;

    event RequestQuery(
        address indexed senderContract,
        bytes32 indexed messageId,
        uint256 chainId,
        address contractAddress,
        uint64 startBlock,
        uint64 endBlock,
        string filter
    );

    function execute(
        Cambrian.Query memory query,
        uint64 startBlock,
        uint64 endBlock
    ) public returns (bytes32) {
        bytes32 messageId = keccak256(
            abi.encodePacked(
                query.chainId,
                query.contractAddress,
                startBlock,
                endBlock,
                query.filter
            )
        );

        emit RequestQuery(
            msg.sender,
            messageId,
            query.chainId,
            query.contractAddress,
            startBlock,
            endBlock,
            query.filter
        );

        return messageId;
    }
}

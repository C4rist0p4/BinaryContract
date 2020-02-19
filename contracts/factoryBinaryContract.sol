pragma solidity ^0.5.0;

import "./binaryContract.sol";
import "./contractRegistry.sol";

contract FactoryBinaryContract is contractRegistry {
    address payable owner;
    binaryContract newbinaryContract;

    constructor() public payable {
        owner = msg.sender;
    }

    function creatContract(uint256 _inset, bool _lowheight) public payable {
        require(msg.value >= _inset, "Not enough ether");
        uint256 inset = _inset * 2;

        newbinaryContract = (new binaryContract).value(inset)(
            _lowheight,
            msg.sender
        );

        setContract(msg.sender, address(newbinaryContract));
    }
}

pragma solidity ^0.5.0;

import "./binaryContract.sol";

contract FactoryBinaryContract {
    struct Contracts {
        binaryContract addaddress;
    }

    mapping(address => Contracts) contracts;

    binaryContract[] public deployedBinaryContract;
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
        contracts[msg.sender].addaddress = newbinaryContract;
    }
}

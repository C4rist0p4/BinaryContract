pragma solidity ^0.5.0;

contract contractRegistry {
    struct Contracts {
        address[] contractaddress;
    }

    mapping(address => Contracts) registry;

    function setContract(address _counterparty, address binaryContract)
        public
        returns (uint256)
    {
        registry[_counterparty].contractaddress.push(binaryContract);
        return registry[_counterparty].contractaddress.length;
    }
    function getContracts() public view returns (address[] memory) {
        return registry[msg.sender].contractaddress;
    }

    function removeContract(address _counterparty, uint256 index)
        public
        returns (bool)
    {
        delete registry[_counterparty].contractaddress[index];
        return true;
    }

}

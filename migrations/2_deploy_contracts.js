const factoryBinaryContract = artifacts.require("factoryBinaryContract.sol");
const integers = artifacts.require("Integers.sol");


module.exports = function(deployer, network, accounts) {
    deployer.deploy(integers);
    deployer.link(integers, factoryBinaryContract);
  deployer.deploy(factoryBinaryContract, {
    value: web3.utils.toWei("0.5", "ether"),
    from: accounts[0]
  });
};
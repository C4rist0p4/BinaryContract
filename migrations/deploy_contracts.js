const binaryContract = artifacts.require("binaryContract.sol");
const integers = artifacts.require("Integers.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(integers);
  deployer.link(integers, binaryContract);
  deployer.deploy(binaryContract, true, accounts[1], {
    value: web3.utils.toWei("1", "ether"),
    from: accounts[0]
  });
};
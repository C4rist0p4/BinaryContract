const Web3 = require("web3");
const factoryBinaryContract = artifacts.require("./factoryBinaryContract.sol");
const web3 = new Web3(
  new Web3.providers.WebsocketProvider("ws://localhost:7545")
);

contract("Factory Contract Tests", accounts => {
  const account = accounts;

  beforeEach(
    async () => (
        this.factory = await factoryBinaryContract.deployed({
        value: web3.utils.toWei("0.5", "ether"),
        from: account[0]
      }))
  );

    it("Creating a new Binary Contract", async () => {
        await this.factory.creatContract(web3.utils.toWei("0.5", "ether"), true, {value: web3.utils.toWei("0.5", "ether"), from: account[2] });  
    });

});

const Web3 = require("web3");
const { waitForEvent } = require("./utils");
const binaryContract = artifacts.require("./binaryContract.sol");
const web3 = new Web3(
  new Web3.providers.WebsocketProvider("ws://localhost:9545")
);

contract("Binary Contract Tests", accounts => {
  const account = accounts;

  beforeEach(
    async () => (
      ({ contract } = await binaryContract.deployed(web3.utils.toWei("1", "ether"), true, account[1], {
        value: web3.utils.toWei("1", "ether"),
        from: account[0]
      })),
       ({ methods, events } = new web3.eth.Contract(
        contract._jsonInterface,
        contract._address
      ))
    )
  );

    it("Callback should log a Updated Price", async () => {
    const {
      returnValues: { price }
    } = await waitForEvent(events.LogPriceUpdate);
    priceUpdate = price;
    assert.isAbove(parseFloat(priceUpdate),
     0,
      "Updated Price is " + priceUpdate
    );
  });

  it("Get the winner", async () => {
    const {
      returnValues: { Query }
    } = await waitForEvent(events.LogNewProvableQuery);
    assert.equal(Query,
     "winner counterparty",
      "Query is " + Query
    );
  });
});

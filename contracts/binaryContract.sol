pragma solidity >=0.5.0 <0.7.0;
import "./provableAPI.sol";
import "./Integers.sol";

contract binaryContract is usingProvable {
    using Integers for uint256;
    address payable owner;
    address payable counterparty;
    uint256 startTime;
    uint256 inset;
    uint256 pricestart = 0;
    uint256 priceUpdate = 0;
    bool lowheight;

    event LogPriceUpdate(string price);
    event LogPriceStart(string price);
    event LogNewProvableQuery(string description);
    event LogWinner(string winner);

    constructor(uint256 _inset, bool _lowheight, address payable _counterparty)
        public
        payable
    {
        require(msg.value >= _inset, "Not enough ether");
        inset = _inset;
        owner = msg.sender;
        lowheight = _lowheight;
        counterparty = _counterparty;
        getPrice(0);
    }

    function __callback(bytes32 _myid, string memory result) public {
        require(
            msg.sender == provable_cbAddress(),
            "Sender is not Provable contract"
        );

        if (pricestart == 0) {
            emit LogPriceStart(result);
            pricestart = Integers.deletePoint(result);
            startTime = now;
            getPrice(10);
        } else {
            priceUpdate = Integers.deletePoint(result);
            emit LogPriceUpdate(result);
            getWinner();
        }
    }

    function getPrice(uint256 time) private {
        if (provable_getPrice("URL") > address(this).balance) {
            emit LogNewProvableQuery(
                "Provable query was NOT sent, please add some ETH to cover for the query fee!"
            );
        } else {
            emit LogNewProvableQuery(
                "Provable query was sent, standing by for the answer..."
            );
            provable_query(
                time,
                "URL",
                "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price"
            );
        }

    }

    function countTime() public view returns (int256) {
        int256 countedSec = int256((120 seconds) - (now - startTime));
        if (countedSec > 0) {
            return countedSec;
        }
        return 0;
    }

    function getWinner() private {
        require(priceUpdate > 0, "Contract need more Time");
        if (priceUpdate > pricestart && lowheight == true) {
            emit LogWinner("winner counterparty");
            selfdestruct(counterparty);
        } else if (priceUpdate < pricestart && lowheight == false) {
            emit LogWinner("winner counterparty");
            selfdestruct(counterparty);
        }
        emit LogWinner("winner owner");
        selfdestruct(owner);
    }
}

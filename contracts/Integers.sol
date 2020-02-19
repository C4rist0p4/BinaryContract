pragma solidity ^0.5.0;

library Integers {
    function deletePoint(string memory _value)
        public
        pure
        returns (uint256 _ret)
    {
        bytes memory _bytesValue = bytes(_value);
        uint256 j = 1;
        for (
            uint256 i = _bytesValue.length - 1;
            i >= 0 && i < _bytesValue.length;
            i--
        ) {
            if (_bytesValue[i] != bytes(".")[0]) {
                assert(
                    uint8(_bytesValue[i]) >= 48 && uint8(_bytesValue[i]) <= 57
                );
                _ret += (uint8(_bytesValue[i]) - 48) * j;
                j *= 10;
            }
        }
    }
}

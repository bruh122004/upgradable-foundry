// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Proxy {

    address public implemetationContract;

    constructor(address _implementaionAddr) {
        implemetationContract = _implementaionAddr;
    }

    fallback() external {
        (bool success,) = implemetationContract.delegatecall(msg.data);
        require(success, "deligate call unseccessful");
    }

    function setLogicAddress(address newImplementation) public {
        implemetationContract = newImplementation;
    }

    function readStorage() public view returns (uint256 valueAtStorageSlotZero) {
    assembly {
        // Load the value from storage slot 0
        valueAtStorageSlotZero := sload(0)
    }
}



}
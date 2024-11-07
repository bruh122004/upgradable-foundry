// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
contract DeployScript is Script{
    function run() public returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        BoxV1 box = new BoxV1(); //our execution contract (logic)
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        return address(proxy);
    
    }
}
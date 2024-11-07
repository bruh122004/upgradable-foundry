// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
contract UpgradeImplementation is Script {
    
    
    function run() external returns(address) {
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment('ERC1967Proxy', block.chainid);
        
    
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeBox(mostRecentlyDeployedProxy, address(newBox));
        return proxy;

    }

    function upgradeBox(address proxyAddress, address newBox) 
    public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(payable(proxyAddress));
        proxy.upgradeTo(newBox);
        vm.stopBroadcast();
        return address(proxy);


    }

}
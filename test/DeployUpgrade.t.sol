// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployScript} from "script/DeployScript.s.sol";
import {UpgradeImplementation} from "script/Upgrade.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract testUpgradableContract is Test {
    DeployScript deployer;
    UpgradeImplementation upgrader;
    address public OWNER = makeAddr('owner');
    BoxV1 public proxy;

    function setUp() public {
        deployer = new DeployScript();
        upgrader = new UpgradeImplementation();
        proxy = BoxV1(deployer.run());
        console.log(address(proxy), "currantly the proxy's implementations conctract is BoxV1");

    
    }
    
    function testUpgrades() public {
        address proxyAddress = deployer.deployBox();

        BoxV2 box2 = new BoxV2();

        vm.prank(BoxV1(proxyAddress).owner());
        BoxV1(proxyAddress).transferOwnership(msg.sender);

        address newproxy = upgrader.upgradeBox(proxyAddress, address(box2));
        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(newproxy).version());

        BoxV2(newproxy).setValue(7);
        assertEq(7, BoxV2(newproxy).getValue());

    }
    //
}
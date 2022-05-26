// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/Contract.sol";
import "../lib/forge-std/lib/ds-test/src/test.sol";

contract ContractTest is DSTest {    
    Contract test_contract;
    function setUp() public {
        test_contract = new Contract();
    }
    function testStoreOK() public {
        test_contract.store(1);
        assertEq(test_contract.retrieve(),1);
    }
    function testSotreNG() public {
        test_contract.store(2);
        assertTrue(test_contract.retrieve()!=3);
    }
    function testStoreFuzzing(uint256 x) public {
        test_contract.store(x);
        assertEq(test_contract.retrieve(), x);
    }
}

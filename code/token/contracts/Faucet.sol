// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract Faucet is Ownable {
	IERC20 public token;

	uint public withdrawalAmount = 50 * (10 ** 18);
	uint public lockTime = 1 minutes;

	event Withdrawal(address indexed to, uint indexed amount);
	event Deposit(address indexed from, uint indexed amount);
	
	mapping(address => uint) nextAccessTime;

	constructor(address tokenAddress) payable Ownable(msg.sender) {
		token = IERC20(tokenAddress);
	}

	function requestTokens() public {
		require(msg.sender != address(0), "Request must not originate from a zero acount");
		require(token.balanceOf(address(this)) >= withdrawalAmount, "Insufficient balance in faucet for withdrawal request.");
		require(block.timestamp >= nextAccessTime[msg.sender], "Insufficient time elapsed since last withdral, try again later.");

		nextAccessTime[msg.sender] = block.timestamp + lockTime;
		token.transfer(msg.sender, withdrawalAmount);
	}

	receive() external payable {
		emit Deposit(msg.sender, msg.value);
	}

	function getBalance() external view returns (uint) {
		return token.balanceOf(address(this));
	}

	function setWithdrawalAmount(uint amount) public onlyOwner {
		withdrawalAmount = amount * (10 ** 18);
	}

	function setLockTime(uint amount) public onlyOwner {
		lockTime = amount * 1 minutes;
	}

	function withdrawal() external onlyOwner {
		emit Withdrawal(msg.sender, token.balanceOf(address(this)));
		token.transfer(msg.sender, token.balanceOf(address(this)));
	}
}
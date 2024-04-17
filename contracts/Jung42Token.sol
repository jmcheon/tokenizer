// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract Jung42Token is ERC20Capped, ERC20Burnable, Ownable {
	uint256 public blockReward;
	constructor(uint256 cap, uint256 reward) ERC20("Jung42Token", "JUNG42") ERC20Capped(cap * (10 ** decimals())) Ownable(msg.sender) {
		_mint(payable(owner()), 70000000 * (10 ** decimals()));
		blockReward = reward * (10 ** decimals());
	}

	function _mintMinerReward() internal {
		_mint(block.coinbase, blockReward);
	}

	function _update(address from, address to, uint256 value) internal virtual override(ERC20Capped, ERC20) {
		if (from != address(0) && to != block.coinbase && block.coinbase != address(0)) {
			_mintMinerReward();
		}
		super._update(from, to, value);
	}

	function setBlockReward(uint256 reward) public onlyOwner {
		blockReward = reward * (10 ** decimals());
	}
}
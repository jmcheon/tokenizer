// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract Jung42Token is ERC20Capped, ERC20Burnable, Ownable {
	uint public blockReward;
	
	constructor(uint _cap, uint _reward) 
		ERC20("Jung42Token", "JUNG42") 
		ERC20Capped(_cap * (10 ** decimals())) 
		Ownable(msg.sender) {
			_mint(payable(owner()), 70000000 * (10 ** decimals()));
			blockReward = _reward * (10 ** decimals());
	}

	function _mintMinerReward() 
		internal {
			_mint(block.coinbase, blockReward);
	}

	function _update(address _from, address _to, uint _value) 
		internal 
		virtual 
		override(ERC20Capped, ERC20) {
			if (_from != address(0) && _to != block.coinbase && block.coinbase != address(0)) {
				_mintMinerReward();
			}
			super._update(_from, _to, _value);
	}

	function setBlockReward(uint _reward) 
		public 
		onlyOwner {
			blockReward = _reward * (10 ** decimals());
	}
}
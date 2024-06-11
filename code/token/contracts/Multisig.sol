// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract Multisig is Ownable {
	// events
	event Deposit(address indexed sender, uint amount, uint balance);
	event SubmitTransaction(
		address indexed owner, 
		uint indexed transactionIndex,
		address indexed to,
		uint value,
		bytes data
		);
	event ConfirmTransaction(address indexed owner, uint indexed transactionIndex);
	event RevokeConfirmation(address indexed owner, uint indexed transactionIndex);
	event ExecuteTransaction(address indexed owner, uint indexed transactionIndex);

	// state variables
	address[] public owners;
	mapping(address => bool) public isOwner;
	uint public numConfirmationsRequired;
	IERC20 public token;

	struct Transaction {
		address to;
		uint value;
		bytes data;
		bool executed;
		// mapping(address => uint) isConfirmed;
		uint numConfirmations;
	}

	mapping(uint256 => mapping(address => bool)) public isConfirmed;

	Transaction[] public transactions;

	constructor(address _tokenAddress, address[] memory _owners, uint _numComfirmationsRequired) Ownable(msg.sender) {
		require(_owners.length > 0, "owners requried");
		require(_numComfirmationsRequired > 0 && _numComfirmationsRequired <= _owners.length, "invalid number of required confirmations");
		token = IERC20(_tokenAddress);
		for (uint i = 0; i < _owners.length; i++) {
			address owner = _owners[i];
			require(owner != address(0), "invalid onwer");
			require(!isOwner[owner], "owner not unique");
			isOwner[owner] = true;
			owners.push(owner);
		}
		numConfirmationsRequired = _numComfirmationsRequired;
	}

	modifier transactionExists(uint _transactionIndex) {
		require(_transactionIndex < transactions.length, "transaction doesn't exist");
		_;
	}
	modifier notExecuted(uint _transactionIndex) {
		require(!transactions[_transactionIndex].executed, "transaction already executed");
		_;
	}
	modifier notConfirmed(uint _transactionIndex) {
		require(!isConfirmed[_transactionIndex][msg.sender], "transaction already confirmed");
		_;
	}

	// functions	
	// fallback function
	receive() payable external {
		emit Deposit(msg.sender, msg.value, address(this).balance);
	}
	// helper function to easily deposit in Remix
	function deposit() payable external {
		emit Deposit(msg.sender, msg.value, address(this).balance);
	}

	function submitTransaction(address _to, uint _value, bytes memory _data) public onlyOwner {
		uint transactionIndex = transactions.length;
		transactions.push(Transaction({
			to: _to,
			value: _value,
			data: _data,
			executed: false,
			numConfirmations: 0
		}));
		emit SubmitTransaction(msg.sender, transactionIndex, _to, _value, _data);
	}
	function confirmTransaction(uint _transactionIndex) 
		public 
		onlyOwner
		transactionExists(_transactionIndex)
		notExecuted(_transactionIndex)
		notConfirmed(_transactionIndex) {
			Transaction storage transaction = transactions[_transactionIndex];

			isConfirmed[_transactionIndex][msg.sender] = true;
			transaction.numConfirmations += 1;

			emit ConfirmTransaction(msg.sender, _transactionIndex);
	}
	function revokeConfirmation(uint _transactionIndex) 
		public 
		onlyOwner
		transactionExists(_transactionIndex)
		notExecuted(_transactionIndex) {
			Transaction storage transaction = transactions[_transactionIndex];

			require(isConfirmed[_transactionIndex][msg.sender], "transaction is not confirmed");
			transaction.numConfirmations -= 1;
			isConfirmed[_transactionIndex][msg.sender] = false;

			emit RevokeConfirmation(msg.sender, _transactionIndex);
		}
	function executeTransaction(uint _transactionIndex)
		public 
		onlyOwner
		transactionExists(_transactionIndex) 
		notExecuted(_transactionIndex) {
			Transaction storage transaction = transactions[_transactionIndex];

			require(transaction.numConfirmations >= numConfirmationsRequired, "cannot execute the trancation");
			transaction.executed = true;
			require(token.transfer(transaction.to, transaction.value), "token transfer failed");

			emit ExecuteTransaction(msg.sender, _transactionIndex);
		}
}
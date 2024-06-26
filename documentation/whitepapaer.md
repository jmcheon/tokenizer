# Whitepaper: Jung42 Token Project

## Introduction
The `Jung42` Token project aims to build a blockchain token for educational purposes, with a unique constraint that it contains the number 42 in its name. `Jung42` Token leverages the ERC-20 standard to facilitate the process of token creation and ensure compatibility with existing decentralized applications and exchanges.

## Technical Details
The `Jung42` Token is built on the Ethereum blockchain platform, utilizing the Solidity programming language for smart contract development. The development environment includes tools such as REMIX and Hardhat, which streamline the process of writing, testing, and deploying smart contracts.

For the token standard, `Jung42` Token leverages the widely adopted ERC-20 standard and incorporates the OpenZeppelin library to ensure robust and secure contract implementation.


## Token Features
### Specifications
-   **Name:** Jung42Token
-   **Ticker Symbol:** JUNG42
-   **Blockchain Network:** Sepolia
-   **Initial Supply:** 70,000,000 (70 million)
-   **Max Supply:** 100,000,000 (100 million)
-   **Block Reward:** 50 tokens per block
-   **Burnable:** Yes
1. Initial Supply
The `Jung42Token` has a fixed initial supply of 70,000,000 tokens. These tokens are minted and attributed to the owner at the time of deployment.

2. Capped Supply
The total supply of the `Jung42Token` is capped at 100,000,000 tokens. This means that no more than 100 million tokens can ever be created, ensuring scarcity and protecting the value of the token.

3. Block Reward
To incentivize network participants, a block reward mechanism is implemented. Each time a transaction is processed, 50 additional tokens are minted and awarded to the miner of the block.  This encourages miners to secure the network and process transactions.

4. Burable Tokens
`Jung42Token` supports the buring of tokens, allowing holders to permanently a portion of their tokens. This feature can be used to reduce the total supply of tokens in circulation, potentially increasing the value of the remaining tokens. The burn functionality adds an additional layer of flexibility and control for token holders.


## Token Faucet

Faucet Contract Address:

The `Jung42Token` ecosystem includes a faucet to distribute small amounts of tokens to users for testing and promotional purposes. Users can request periodically, subject to a lock time to prevent abuse.

Faucet Features
1. Withdrawal Amount
Users can withdrawal 50 `JUNG42` tokens per request

2. Lock Time
There is a 1 minute lock time between requests from the same address

3. Admin Controls
The owner can adjust the withdrawal amount and lock time 

## Multisig Wallet

A multisig wallet stands for a multi-signature wallet and it is a wallet that has many owners. To spend from this wallet an owner needs approvals of other owners. There are a minimun number of approvals that are required to execute the transaction.

If there are 3 owners and an owner wants to spend from this wallet and it requires 2 approvals, it is called 2-out-of-3 multisig wallet. since it requires at least 2 approvals out of 3 owners.

### Multisig Contract
#### Functions
These are the functions that the contract needs.

- submitTransaction():`submitTransaction(address _to, uint _value, bytes memory _data)`
An onwer will have to propose a transaction that must be approved by other owners by calling this function.
When an onwer submit a transaction, they need to send the address `_to` that the transaction will be fall and the amount `_value` that will be sent to that address and the transaction data `_data` that will be sent.

- confirmTransaction():`confirmTransaction(uint _transactionIndex)`
The other owners can approve the proposed transactions by calling this function.

- revokeConfirmation():
If the owner decides to cancel the confirmation, they can call this function.

- executeTransaction():`executeTransaction(uint _transactionIndex)`
If enough onwers have approved the proposed transaction, this function can be called.

#### Actions
1. Submit a Transaction: An owner proposes a transaction specifying the recipient address, value, and data.
2. Confirm a Transaction: Other owners approve the proposed transaction.
3. Revoke Confirmation: Owners can cacel their approval before the transaction is executed.
4. Execute a Transaction: Once enough confirmations are received, the transaction can be executed, sending Ether and data to the recipient. 

## Deployment and Usage
### Token
Deploy the `Jung42Token` contract using the provided script.
```
deploy_token.sh 
```
### Faucet
Deploy the faucet contract after deploying the `Jung42Token` contract. Ensure that the faucet has an initial balance of `Jung42Token` tokens to distribute.
```
deploy_faucet.sh 
```
### Multisig
1. Deploying the Contract: Deploy the multisig contract with the initial set of owners and the required number of confirmations.
2. Interacting with the Contract: Use provided functions(`submitTransaction`, '-`confirmTransaction`, `revokeConfirmation`, `executeTransaction`) to manage and approve transactions collectively.
```
deploy_multisig.sh 
```
## Conclusion

`Jung42Token` is designed with a focus on security, transparency and utility. Its capped supply, burable nature, and incentivization through block reward position it as a versatile and valuable digital asset within the Ethereum ecosystem. `Jung42Token`  adheres to the `ERC-20` standard and leveraging the strengths of the `Sepolia` network.

### Contract Info

| Component       | Contract Name | Symbol | Contract Address                          |
|-----------------|----------------|--------|-------------------------------------------|
| **Token**       | Jung42Token    | JUNG42 | 0x6Eb3eA000c4591f9dCEFc5E869E0A19628e8a4c2|
| **Faucet**      | Faucet         | -      | 0x27D4f66748EAea5e9769baAF1bB223F841fab21E|
| **Multi-Signature** | Multisig       | -      | 0x5280d7AbD73dD78EA0C60FB347c508Ce68fAAb73|


### Summary Table

| Feature             | Description                                                      |
|---------------------|-------------------------------------------------|
| **Initial Supply**  | 70,000,000 tokens|
| **Capped Supply**   | 100,000,000 tokens|
| **Block Reward**    | 50 tokens per block|
| **Burnable**        | Yes|
| **Token Name**      | Jung42Token|
| **Ticker Symbol**   | JUNG42|
| **Blockchain**      | Sepolia|
| **ERC-20 Compliant**| Ensures compatibility with Ethereum wallets and exchanges|
| **Security**        | Built using OpenZeppelin libraries to ensure high security|
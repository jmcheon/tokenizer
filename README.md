# Tokenizer: Build your own digital token

> __Summary: This is a Web3 related exercise.__

## Requirements
- Solidity ^0.8.24
- Hardhat ^2.22.2
- OpenZeppelin Contracts v5.x (specifically v5.0.2)
- Remix IDE v0.47.0 (utilized for development)

## Project Directory Structure

### `code/`
This directory contains the complete codebase for the **Jung42** smart contract, which follows  the ERC-20 standard.

### `deployment/`
This directory contains the script files for deploying contracts available in `code/` directory, and for some environmental setup.

### `documentation/`
In this directory, the whitepaper of `Jung42Token` project can be found, which explains the functioning of each contract and its actions in detail.

## Choice of Blockchain: Ethereum
I chose the Ethereum blockchain for its widely adopted smart contract capabilities, which facilitate the development of decentralized applications (DApps), including blockchain tokens using the ERC-20 standard. Ethereum's active developer community, scalability solutions, and established ecosystem make it an ideal platform for building innovative blockchain-based solutions.

## Contract Info
| Component       | Contract Name | Symbol | Contract Address|
|-----------------|----------------|--------|---------------|
| **Token**       | [Jung42Token](https://sepolia.etherscan.io/address/0x6Eb3eA000c4591f9dCEFc5E869E0A19628e8a4c2)    | JUNG42 | 0x6Eb3eA000c4591f9dCEFc5E869E0A19628e8a4c2|
| **Faucet**      | [Faucet](https://sepolia.etherscan.io/address/0x27d4f66748eaea5e9769baaf1bb223f841fab21e)         | -      | 0x27D4f66748EAea5e9769baAF1bB223F841fab21E|
| **Multi-Signature** |[Multisig](https://sepolia.etherscan.io/address/0x5280d7abd73dd78ea0c60fb347c508ce68faab73)       | -      | 0x5280d7AbD73dD78EA0C60FB347c508Ce68fAAb73|

## Background knowledge
- Web3
- Smart-contract
- DApps
- ERC-20
- Solidity

<br/>

### What is WEB3
Web3 refers to the next generation of the World Wide Web, where decentralized and blockchain-based technologies play a central role. It is often associated with concepts such as decentralization, peer-to-peer networks, and the use of blockchain for secure and transparent transactions. 

#### Key difference between Web3 and Web3
| Aspect            | Web2                                      | Web3         |                       
|-------------------|--------------------|-------------------------------------|
| **Architecture**  | Centralized                               | Decentralized |                   
| **Data Storage**  | Centralized servers                       | Blockchain and distributed networks       |
| **Control**       | Controlled by a few large entities        | User-controlled  |
| **Intermediaries**| Requires intermediaries                   | Peer-to-peer       |
| **Security**      | Vulnerable to hacks and data breaches     | Enhanced security through decentralization|
| **Transparency**  | Limited                                   | Full transparency through blockchain      |
| **Applications**  | Web applications                          | Decentralized applications (dApps)        |

<br/>

### Smart Contracts
Smart contracts are the fundamental building blocks for Ethereum's application layer. **They are computer programs stored on the blockchain** that follow "if this then that" logic, and are guaranteed to execute according to the rules defined by its code, which can not be changed once created.

<br/>

### DApps
DApps are applications run on decentralized networks rather than centralized servers. They leverage smart contracts for their backend logic and blockchain for data storage, ensuring greater transparency and security.

<br/>

### ERC-20
ERC-20 is a technical standard used for smart contracts on the Ethereum blockchain. It defines a set of rules and functions that a token contract must implement to be compatible with the Ethereum network. This standard allows developers to create interoperable tokens that can work with various DApps and other contracts on the Ethereum platform.

<br/>

### Solidity
Solidity is the most widely used and officially supported language for Ethereum smart contract development.

#### solidity convention

- Function declarations
it's convention (but not required) to start function parameter variable names with an underscore (`_`) in order to differentiate them from global variables
- Private / Public Functions
it's convention to start private function names with an underscore (`_`).

#### side note
- Solidity doesn't have native string comparison, so we compare their `keccak256` hashes to see if the strings are equal
- In Solidity, there are two locations you can store variables — in  `storage`  and in  `memory`.
- **_Storage_**  refers to variables stored permanently on the blockchain.  **_Memory_**  variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.
- in Solidity you can return more than one value from a function.
- `uint`  is an alias for  `uint256`  — they're the same thing.

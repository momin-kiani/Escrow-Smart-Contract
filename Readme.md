# Blockchain Escrow System using ERC-20 Token (Quecko Coin)

## 🚀 Live Demo

[![Open Escrow Contract in Remix](https://img.shields.io/badge/Open%20Escrow%20in-Remix-blue?logo=ethereum)](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.30+commit.73712a01.js&url=https://github.com/momin-kiani/Escrow-Smart-Contract/blob/main/escrow.sol)

[![Open Token Contract in Remix](https://img.shields.io/badge/Open%20Token%20in-Remix-blue?logo=ethereum)](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.30+commit.73712a01.js&url=https://github.com/momin-kiani/Escrow-Smart-Contract/blob/main/ERC-20-Token.sol)


This repository contains two core Solidity smart contracts:

1. **Token.sol** — A custom ERC-20 token implementation called **Quecko Coin (QUE)**.
2. **Escrow.sol** — A secure escrow contract supporting both **ETH and ERC-20 token deposits**, with time-based release logic and recipient confirmation.

---

## 🧩 Overview

This project demonstrates a real-world **blockchain escrow workflow**, where a depositor locks funds and tokens until both parties approve or certain time conditions are met.

**Key Features**

* Custom ERC-20 Token (QUE)
* Time-based escrow logic
* Dual asset handling (ETH + ERC-20)
* Safe fund release and cancellation mechanisms
* Recipient confirmation using `greenFlag` logic
* Built-in buffer period for cancellation

---

## 📁 File Structure

```
📦 Escrow-Smart-Contract
 ┣ 📜 Token.sol
 ┣ 📜 Escrow.sol
 ┗ 📜 README.md
```

---

## 🧠 Smart Contract Summary

### **Token.sol**

Implements the ERC-20 token standard with:

* Total supply of **1 million QUE**
* 18 decimals
* Fully transferable and spendable tokens
* Standard ERC-20 functions:

  * `transfer()`, `approve()`, `transferFrom()`, `allowance()`, `balanceOf()`

**Deployment**

* Automatically mints total supply to a predefined address (`0x5B38Da6a...`).

---

### **Escrow.sol**

A dual-asset escrow mechanism enabling ETH and ERC-20 deposits, with time and permission logic.

#### Workflow

1. **Depositor** deploys contract and deposits ETH + tokens.
2. **Recipients (Token + ETH)** must give approval using `giveGreenFlag()`.
3. Funds are released incrementally based on elapsed time.
4. Escrow can be **cancelled** before start or **after buffer** if recipients agree.

**Core Functions**

* `depositTokens(uint amount)`
* `depositETH() payable`
* `claimTokens()`
* `claimETH()`
* `cancelEscrow()`
* `cancelAfterBuffer()`
* `giveGreenFlag()`

---

## ⚙️ Deployment Steps (via Remix IDE)

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create two files:

   * `Token.sol`
   * `Escrow.sol`
3. Compile using **Solidity ^0.8.17** or above.
4. Deploy `Token.sol` first and copy its contract address.
5. Deploy `Escrow.sol` using:

   * `_tokenRecipient`: Token receiver address
   * `_ethRecipient`: ETH receiver address
   * `_tokenAddress`: Address of deployed Quecko Coin
6. Test deposit, claim, and cancel functions using **MetaMask**.

---

## 🧪 Example Demo

### GitHub Repository

[Sample Repo Link (placeholder)](https://github.com/momin-kiani/Escrow-Smart-Contract)

### Remix Demo

[Try on Remix (placeholder)](https://remix.ethereum.org)

---

## 🧰 Tech Stack

| Tool                           | Purpose                                     |
| ------------------------------ | ------------------------------------------- |
| **Solidity**                   | Smart contract logic                        |
| **Remix IDE**                  | Writing, compiling, and deploying contracts |
| **MetaMask**                   | Wallet and test network interaction         |
| **Ethereum Testnet (Sepolia)** | Deployment and testing environment          |

---

## 🧾 License

This project is licensed under the **MIT License** — you are free to modify and use it for educational or professional purposes.

---

## ✨ Author

**Momin Kiani**
Blockchain Developer Intern
🔗 [GitHub Profile](https://github.com/momin-kiani)

---

## 📅 Project Duration

**Start Date:** September 17, 2025
**Expected Completion:** November 18, 2025

---

## 🚀 Future Enhancements

* UI integration using React + Web3.js
* Multi-party escrow (3+ participants)
* Automated milestone-based token release
* Off-chain notifications via Chainlink or Oracles

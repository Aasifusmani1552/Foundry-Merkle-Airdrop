# 🥯 BagelToken Airdrop

Welcome to the **BagelToken Airdrop** project – a full-stack, Merkle Tree-based airdrop system built with security, simplicity, and transparency in mind. BagelToken (`BagelToken.sol`) is an ERC-20 token that can be distributed to users through a gas-efficient and verifiable **Merkle Airdrop** process.

## ✨ Features

- ✅ **ERC-20 Token Airdrop**: Built around a custom token called `BagelToken`, designed for fair and efficient distribution.
- 🌳 **Merkle Tree-Based Verification**: Uses a Merkle tree and Merkle proofs to validate claim eligibility on-chain via the `MerkleAirdrop` contract.
- 🔏 **Signature Verification**: Leveraging OpenZeppelin's ECDSA library to ensure only valid claims are processed.
- ⚙️ **Script-Driven Automation**: Complete setup and claim process via powerful Foundry scripts.
- 🧪 **Fully Testable Setup**: Includes fake and Anvil addresses for easy local testing.

---

## 🧱 How It Works

### 📦 Token Contract

- **`BagelToken.sol`**  
  An ERC-20 contract that mints tokens meant for airdropping to eligible users.

### 🌐 Airdrop Contract

- **`MerkleAirdrop.sol`**  
  This is the heart of the system. It receives the Merkle root generated off-chain and uses it to verify claims efficiently using Merkle proofs.

---

## 🛠 Scripts Overview

### 🔢 `GenerateInput.s.sol`

Generates a JSON file containing addresses and airdrop amounts. This includes:
- A few **fake addresses** (for demo).
- One **Anvil address** (for local testing).

📁 Output: `script/target/input.json`

### 🤝 `Interact.s.sol`

Simulates or executes the **claim process** using the proof and the claimer address.

> ℹ️ **Note**: Since this is set up for testing with fake/Anvil addresses, the claimer address is **hardcoded** in the script.  
> To deploy on testnets or mainnet, **update the input file** with real EOAs and modify the script logic accordingly.

---

## 📂 Folder Structure

```
contracts/
  ├─ BagelToken.sol
  └─ MerkleAirdrop.sol

script/
  ├─ GenerateInput.s.sol
  ├─ MakeMerkle.s.sol
  ├─ Interact.s.sol
  └─ target/
       ├─ input.json
       └─ merkle.json
```

---

## 🚀 Deploying & Testing

1. Generate the airdrop list:
   ```bash
   forge script script/GenerateInput.s.sol
   ```

2. Create the Merkle tree:
   ```bash
   forge script script/MakeMerkle.s.sol
   ```

3. Deploy the contracts and claim:
   ```bash
   forge script script/DeployMerkleAirdrop.s.sol
   forge script script/Interact.s.sol
   ```

> 🧪 You can test this setup using [Anvil](https://book.getfoundry.sh/anvil/) or any local blockchain.  
> Simply run `anvil` and use one of the accounts it provides in the input list.

---

## 📌 Notes

- The current setup is designed for **testing and educational purposes**.
- To go live on a testnet or mainnet:
  - Replace the fake addresses in `input.json` with real ones.
  - Re-run the scripts to generate a new Merkle root.
  - Deploy and verify contracts accordingly.

---

## 🙌 Acknowledgements

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
---

## 🧁 Enjoy the Bagel Drop!

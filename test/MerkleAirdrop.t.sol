//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {BagelToken} from "src/BagelToken.sol";
import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {DevOpsTools} from "@foundry-devops/src/DevOpsTools.sol";
import {ZkSyncChainChecker} from "@foundry-devops/src/ZkSyncChainChecker.sol";
import {DeployMerkleAirdrop} from "script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is Test, ZkSyncChainChecker {
    MerkleAirdrop public airdrop;
    BagelToken public token;

    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT_TO_CLAIM = 25 * 1e18;
    uint256 public AMOUNT_TO_MINT = AMOUNT_TO_CLAIM * 4;
    bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] proof = [proofOne, proofTwo];
    address gasPayer;
    address user;
    uint256 userPrivKey;

    function setUp() public {
        if (!isZkSyncChain()) {
            //ZksyncChainChecker provide these functions to work with zksync
            console2.log("testing on zksync");
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (token, airdrop) = deployer.run();
        } else {
            token = new BagelToken();
            airdrop = new MerkleAirdrop(ROOT, token);
            token.mint(token.owner(), AMOUNT_TO_MINT);
            token.transfer(address(airdrop), AMOUNT_TO_MINT);
        }
        (user, userPrivKey) = makeAddrAndKey("user"); // this foundry function creates address as well as a private key for simulation
        gasPayer = makeAddr("gasPayer");
    }
    //This digest is what’s signed with your private key

    function testUsersCanClaim() public {
        uint256 startingBalance = token.balanceOf(user);
        bytes32 digest = airdrop.getMessageHash(user, AMOUNT_TO_CLAIM);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivKey, digest); // as we created a signature for the digest, we prank with other user to see if they can claim for us
        vm.prank(gasPayer);
        airdrop.claim(user, AMOUNT_TO_CLAIM, proof, v, r, s);

        uint256 endingBalance = token.balanceOf(user);
        console2.log(endingBalance);

        assertEq(endingBalance - startingBalance, AMOUNT_TO_CLAIM);
    }
}
